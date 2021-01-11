import Foundation

/*
 SwiftGraphQL has no client as it needs no state. Developers
 should take care of caching and other implementation themselves.
 
 The following code defines a SwiftGraphQL namespace and exposes functions
 that developers can use to execute queries against their server.
 */

public struct SwiftGraphQL {
    // MARK: - Public Methods
    
    /// Sends a query request to the server.
    public static func send<Type, TypeLock>(
        _ selection: Selection<Type, TypeLock?>,
        /// Server endpoint URL.
        to endpoint: String,
        /// The name of the GraphQL query.
        operationName: String? = nil,
        /// A dictionary of key-value header pairs.
        headers: HttpHeaders = [:],
        /// Method to use. (Default to POST).
        method: HttpMethod = .post,
        onComplete completionHandler: @escaping (Response<Type, TypeLock>) -> Void
    ) -> Void where TypeLock: GraphQLOperation & Decodable {
        perform(
            selection: selection,
            operationName: operationName,
            endpoint: endpoint,
            method: method,
            headers: headers,
            completionHandler: completionHandler
        )
    }
    
    /// Sends a query request to the server.
    ///
    /// - Note: This is a shortcut function for when you are expecting the result.
    ///         The only difference between this one and the other one is that you may select
    ///         on non-nullable TypeLock instead of a nullable one.
    public static func send<Type, TypeLock>(
        _ selection: Selection<Type, TypeLock>,
        /// Server endpoint URL.
        to endpoint: String,
        /// The name of the GraphQL query.
        operationName: String? = nil,
        /// A dictionary of key-value header pairs.
        headers: HttpHeaders = [:],
        /// Method to use. (Default to POST).
        method: HttpMethod = .post,
        /// Response handler function.
        onComplete completionHandler: @escaping (Response<Type, TypeLock>) -> Void
    ) -> Void where TypeLock: GraphQLOperation & Decodable {
        perform(
            selection: selection.nonNullOrFail,
            operationName: operationName,
            endpoint: endpoint,
            method: method,
            headers: headers,
            completionHandler: completionHandler
        )
    }
    
    // MARK: Subscriptions
    
    /// Sends a subscription **once**. Use `observe` to listen to changes
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public static func send<Type, TypeLock>(
        _ selection: Selection<Type, TypeLock?>,
        /// Server endpoint URL.
        to endpoint: String,
        /// The name of the GraphQL query.
        operationName: String? = nil,
        /// A dictionary of key-value header pairs.
        headers: HttpHeaders = [:],
        /// Method to use. (Default to POST).
        method: HttpMethod = .post,
        onComplete completionHandler: @escaping (Response<Type, TypeLock>) -> Void
    ) -> Void where TypeLock: GraphQLSubscription & Decodable {
        var token: Token?
        _ = token // Removes warning: variable 'token' was written to, but never read
        token = listen(
            selection: selection,
            operationName: operationName,
            endpoint: endpoint,
            eventHandler: {
                guard token != nil else { return } // Don't call completionHandler for the HttpError.cancelled changeHandler
                completionHandler($0)
                token = nil
            }
        )
    }
    
    /// Sends a subscription **once**. Use `observe` to listen to changes
    ///
    /// - Note: This is a shortcut function for when you are expecting the result.
    ///         The only difference between this one and the other one is that you may select
    ///         on non-nullable TypeLock instead of a nullable one.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public static func send<Type, TypeLock>(
        _ selection: Selection<Type, TypeLock>,
        /// Server endpoint URL.
        to endpoint: String,
        /// The name of the GraphQL query.
        operationName: String? = nil,
        /// A dictionary of key-value header pairs.
        headers: HttpHeaders = [:],
        /// Method to use. (Default to POST).
        method: HttpMethod = .post,
        onComplete completionHandler: @escaping (Response<Type, TypeLock>) -> Void
    ) -> Void where TypeLock: GraphQLSubscription & Decodable {
        send(selection.nonNullOrFail,
             to: endpoint,
             operationName: operationName,
             headers: headers,
             method: method,
             onComplete: completionHandler)
    }
    
    /// Observe a subscription for as long as you keep Token in memory
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public static func observe<Type, TypeLock>(
        _ selection: Selection<Type, TypeLock?>,
        /// Server endpoint URL.
        to endpoint: String,
        /// The name of the GraphQL query.
        operationName: String? = nil,
        /// The web socket protocols
        protocols: [String] = ["graphql-subscriptions"],
        onEvent eventHandler: @escaping (Response<Type, TypeLock>) -> Void
    ) -> Token where TypeLock: GraphQLSubscription & Decodable {
        listen(
            selection: selection,
            operationName: operationName,
            endpoint: endpoint,
            protocols: protocols,
            eventHandler: eventHandler
        )
    }
    
    /// Observe a subscription for as long as you keep Token in memory
    ///
    /// - Note: This is a shortcut function for when you are expecting the result.
    ///         The only difference between this one and the other one is that you may select
    ///         on non-nullable TypeLock instead of a nullable one.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public static func observe<Type, TypeLock>(
        _ selection: Selection<Type, TypeLock>,
        /// Server endpoint URL.
        to endpoint: String,
        /// The name of the GraphQL query.
        operationName: String? = nil,
        /// The web socket protocols
        protocols: [String] = ["graphql-subscriptions"],
        onEvent eventHandler: @escaping (Response<Type, TypeLock>) -> Void
    ) -> Token where TypeLock: GraphQLSubscription & Decodable {
        listen(
            selection: selection.nonNullOrFail,
            operationName: operationName,
            endpoint: endpoint,
            protocols: protocols,
            eventHandler: eventHandler
        )
    }
    
    /// Represents an error of the actual request.
    public enum HttpError: Error {
        case badURL
        case timeout
        case network(Error)
        case badpayload
        case badstatus
        case cancelled
    }
    
    public enum HttpMethod: String, Equatable {
        case get = "GET"
        case post = "POST"
    }
    
    public typealias Response<Type, TypeLock> = Result<GraphQLResult<Type, TypeLock>, HttpError>
    
    public typealias HttpHeaders = [String: String]
    
    // MARK: - Private helpers
    
    private static func perform<Type, TypeLock>(
        selection: Selection<Type, TypeLock?>,
        operationName: String?,
        endpoint: String,
        method: HttpMethod,
        headers: HttpHeaders,
        completionHandler: @escaping (Response<Type, TypeLock>) -> Void
    ) -> Void where TypeLock: GraphQLOperation & Decodable {
        
        // Construct a URL from string.
        guard let url = URL(string: endpoint) else {
            return completionHandler(.failure(.badURL))
        }
        
        // Construct a request.
        var request = URLRequest(url: url)
        
        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        
        
        // Compose a query.
        let query = selection.selection.serialize(for: TypeLock.operation, operationName: operationName)
        var variables = [String: NSObject]()
        
        for argument in selection.selection.arguments {
            variables[argument.hash] = argument.value
        }
        
        // Construct a request body.
        var body: [String: Any] = [
            "query": query,
            "variables": variables,
        ]
        
        if let operationName = operationName {
            // Add the operation name to the request body if needed.
            body["operationName"] = operationName
        }
        
        // Construct a HTTP request.
        let httpBody = try! JSONSerialization.data(
            withJSONObject: body,
            options: JSONSerialization.WritingOptions()
        )
        request.httpBody = httpBody
        
        // Create a completion handler.
        func onComplete(data: Data?, response: URLResponse?, error: Error?) -> Void {
            
            /* Process the response. */
            // Check for HTTP errors.
            if let error = error {
                return completionHandler(.failure(.network(error)))
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                return completionHandler(.failure(.badstatus))
            }
            
            // Try to serialize the response.
            if let data = data, let result = try? GraphQLResult(data, with: selection) {
                return completionHandler(.success(result))
            }
            
            return completionHandler(.failure(.badpayload))
        }
        
        // Construct a session.
        URLSession.shared.dataTask(with: request, completionHandler: onComplete).resume()
    }
    
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private static func listen<Type, TypeLock>(
        selection: Selection<Type, TypeLock?>,
        operationName: String?,
        endpoint: String,
        protocols: [String] = ["graphql-subscriptions"],
        eventHandler: @escaping (Response<Type, TypeLock>) -> Void
    ) -> Token where TypeLock: GraphQLSubscription & Decodable {
        
        var endpoint = endpoint
        if endpoint.hasPrefix("http") {
            endpoint = "ws" + endpoint.dropFirst("http".count)
            print("Modified endpoint scheme to work with web sockets:", endpoint)
        }
        
        // Construct a URL from string.
        guard let url = URL(string: endpoint), ["ws", "wss"].contains(url.scheme) else {
            eventHandler(.failure(.badURL))
            return Token(onDeinit: {})
        }
        
        // Compose a query.
        let query = selection.selection.serialize(for: TypeLock.operation, operationName: operationName)
        var variables = [String: NSObject]()
        
        for argument in selection.selection.arguments {
            variables[argument.hash] = argument.value
        }
        
        // Construct a request body.
        let body: [String: Any] = [
            "payload": [
                "query": query,
                "variables": variables,
                "operationName": operationName as Any
            ],
            "type": "start"
//            "id": UUID().uuidString
        ]
        
        let bodyData = try! JSONSerialization.data(
            withJSONObject: body,
            options: JSONSerialization.WritingOptions()
        )
        
        
        // Create a completion handler.
        func receiveNext(on socket: URLSessionWebSocketTask?) {
            socket?.receive { [weak socket] result in
                /* Process the response. */
                switch result {
                case .failure(let error):
                    if socket?.closeReason == WebSocketCloseReason.tokenDeinit {
                        return eventHandler(.failure(.cancelled))
                    } else {
                        return eventHandler(.failure(.network(error)))
                    }
                case .success(let message):
                    // Try to serialize the response.
                    if let data = message.data,
                       let result = try? GraphQLResult(webSocketResponse: data, with: selection) {
                        eventHandler(.success(result))
                    } else {
                        eventHandler(.failure(.badpayload))
                    }
                }
                
                // Receive next message
                receiveNext(on: socket)
            }
        }
            
        // Construct a session.
        let socket: URLSessionWebSocketTask = URLSession.shared.webSocketTask(with: url, protocols: protocols)

        // Attach receiver
        receiveNext(on: socket)
    
        // Send body
        socket.send(.data(bodyData)) { error in
            if error != nil {
                eventHandler(.failure(.badpayload))
            }
        }
        socket.resume()

        return Token {
            socket.cancel(with: .goingAway, reason: WebSocketCloseReason.tokenDeinit)
        }
    }
}

extension SwiftGraphQL.HttpError: Equatable {
    public static func == (lhs: SwiftGraphQL.HttpError, rhs: SwiftGraphQL.HttpError) -> Bool {
        
        // Equals if they are of the same type, different otherwise.
        switch (lhs, rhs) {
        case (.badURL, badURL),
             (.timeout, .timeout),
             (.badpayload, .badpayload),
             (.badstatus, .badstatus):
            return true
        default:
            return false
        }
    }
}

public class Token {
    private var onDeinit: () -> Void
    internal init(onDeinit: @escaping () -> Void) {
        self.onDeinit = onDeinit
    }
    deinit {
        onDeinit()
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension URLSessionWebSocketTask.Message {
    var data: Data? {
        switch self {
        case .data(let data):
            return data
        case .string(let string):
            return string.data(using: .utf8)
        }
    }
}

internal enum WebSocketCloseReason {
    static var tokenDeinit = "Token deinit".data(using: .utf8)
}
