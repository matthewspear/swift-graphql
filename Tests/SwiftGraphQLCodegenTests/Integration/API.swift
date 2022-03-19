// This file was auto-generated using maticzav/swift-graphql. DO NOT EDIT MANUALLY!
import Foundation
import SwiftGraphQL

// MARK: - Operations
enum Operations {}
extension Objects.Query: GraphQLHttpOperation {
  public static var operation: GraphQLOperationKind { .query }
}
extension Objects.Mutation: GraphQLHttpOperation {
  public static var operation: GraphQLOperationKind { .mutation }
}
extension Objects.Subscription: GraphQLWebSocketOperation {
  public static var operation: GraphQLOperationKind { .subscription }
}

// MARK: - Objects
enum Objects {}
extension Objects {
  struct User {
    let __typename: TypeName = .user
    let iduser: [String: String]
    let usernameuser: [String: String]

    enum TypeName: String, Codable {
      case user = "User"
    }
  }
}

extension Objects.User: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

    var map = HashMap()
    for codingKey in container.allKeys {
      if codingKey.isTypenameKey { continue }

      let alias = codingKey.stringValue
      let field = GraphQLField.getFieldNameFromAlias(alias)

      switch field {
      case "iduser":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "usernameuser":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      default:
        throw DecodingError.dataCorrupted(
          DecodingError.Context(
            codingPath: decoder.codingPath,
            debugDescription: "Unknown key \(field)."
          )
        )
      }
    }

    self.iduser = map["iduser"]
    self.usernameuser = map["usernameuser"]
  }
}

extension Fields where TypeLock == Objects.User {

  func id() throws -> String {
    let field = GraphQLField.leaf(
      field: "id",
      parent: "User",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.iduser[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }
  /// A nickname user has picked for themself.

  func username() throws -> String {
    let field = GraphQLField.leaf(
      field: "username",
      parent: "User",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.usernameuser[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }
}
extension Selection where TypeLock == Never, Type == Never {
  typealias User<T> = Selection<T, Objects.User>
}
extension Objects {
  struct Query {
    let __typename: TypeName = .query
    let charactersquery: [String: [Objects.Character]]
    let comicsquery: [String: [Objects.Comic]]
    let helloquery: [String: String]
    let searchquery: [String: [Unions.SearchResult]]
    let userquery: [String: Objects.User]

    enum TypeName: String, Codable {
      case query = "Query"
    }
  }
}

extension Objects.Query: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

    var map = HashMap()
    for codingKey in container.allKeys {
      if codingKey.isTypenameKey { continue }

      let alias = codingKey.stringValue
      let field = GraphQLField.getFieldNameFromAlias(alias)

      switch field {
      case "helloquery":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "userquery":
        if let value = try container.decode(Objects.User?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "comicsquery":
        if let value = try container.decode([Objects.Comic]?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "charactersquery":
        if let value = try container.decode([Objects.Character]?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "searchquery":
        if let value = try container.decode([Unions.SearchResult]?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      default:
        throw DecodingError.dataCorrupted(
          DecodingError.Context(
            codingPath: decoder.codingPath,
            debugDescription: "Unknown key \(field)."
          )
        )
      }
    }

    self.helloquery = map["helloquery"]
    self.userquery = map["userquery"]
    self.comicsquery = map["comicsquery"]
    self.charactersquery = map["charactersquery"]
    self.searchquery = map["searchquery"]
  }
}

extension Fields where TypeLock == Objects.Query {
  /// Simple field that always returns "Hello world!".

  func hello() throws -> String {
    let field = GraphQLField.leaf(
      field: "hello",
      parent: "Query",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.helloquery[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }
  /// Returns currently authenticated user and errors if there's no authenticated user.

  func user<T>(selection: Selection<T, Objects.User>) throws -> T {
    let field = GraphQLField.composite(
      field: "user",
      parent: "Query",
      type: "User",
      arguments: [],
      selection: selection.__selection()
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.userquery[field.alias!] {
        return try selection.__decode(data: data)
      }
      throw SelectionError.badpayload
    case .mocking:
      return try selection.__mock()
    }
  }
  /// Returns a list of comics from the Marvel universe.

  func comics<T>(
    pagination: OptionalArgument<InputObjects.Pagination> = .init(),
    selection: Selection<T, [Objects.Comic]>
  ) throws -> T {
    let field = GraphQLField.composite(
      field: "comics",
      parent: "Query",
      type: "Comic",
      arguments: [Argument(name: "pagination", type: "Pagination", value: pagination)],
      selection: selection.__selection()
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.comicsquery[field.alias!] {
        return try selection.__decode(data: data)
      }
      throw SelectionError.badpayload
    case .mocking:
      return try selection.__mock()
    }
  }
  /// Returns a list of characters from the Marvel universe.

  func characters<T>(
    pagination: OptionalArgument<InputObjects.Pagination> = .init(),
    selection: Selection<T, [Objects.Character]>
  ) throws -> T {
    let field = GraphQLField.composite(
      field: "characters",
      parent: "Query",
      type: "Character",
      arguments: [Argument(name: "pagination", type: "Pagination", value: pagination)],
      selection: selection.__selection()
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.charactersquery[field.alias!] {
        return try selection.__decode(data: data)
      }
      throw SelectionError.badpayload
    case .mocking:
      return try selection.__mock()
    }
  }
  /// Searches all characters and comics by name and returns those whose
  /// name starts with the query string.

  func search<T>(
    query: InputObjects.Search, pagination: OptionalArgument<InputObjects.Pagination> = .init(),
    selection: Selection<T, [Unions.SearchResult]>
  ) throws -> T {
    let field = GraphQLField.composite(
      field: "search",
      parent: "Query",
      type: "SearchResult",
      arguments: [
        Argument(name: "query", type: "Search!", value: query),
        Argument(name: "pagination", type: "Pagination", value: pagination),
      ],
      selection: selection.__selection()
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.searchquery[field.alias!] {
        return try selection.__decode(data: data)
      }
      throw SelectionError.badpayload
    case .mocking:
      return try selection.__mock()
    }
  }
}
extension Selection where TypeLock == Never, Type == Never {
  typealias Query<T> = Selection<T, Objects.Query>
}
extension Objects {
  struct Character {
    let __typename: TypeName = .character
    let descriptioncharacter: [String: String]
    let idcharacter: [String: String]
    let imagecharacter: [String: String]
    let namecharacter: [String: String]
    let starredcharacter: [String: Bool]

    enum TypeName: String, Codable {
      case character = "Character"
    }
  }
}

extension Objects.Character: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

    var map = HashMap()
    for codingKey in container.allKeys {
      if codingKey.isTypenameKey { continue }

      let alias = codingKey.stringValue
      let field = GraphQLField.getFieldNameFromAlias(alias)

      switch field {
      case "idcharacter":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "namecharacter":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "descriptioncharacter":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "imagecharacter":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "starredcharacter":
        if let value = try container.decode(Bool?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      default:
        throw DecodingError.dataCorrupted(
          DecodingError.Context(
            codingPath: decoder.codingPath,
            debugDescription: "Unknown key \(field)."
          )
        )
      }
    }

    self.idcharacter = map["idcharacter"]
    self.namecharacter = map["namecharacter"]
    self.descriptioncharacter = map["descriptioncharacter"]
    self.imagecharacter = map["imagecharacter"]
    self.starredcharacter = map["starredcharacter"]
  }
}

extension Fields where TypeLock == Objects.Character {

  func id() throws -> String {
    let field = GraphQLField.leaf(
      field: "id",
      parent: "Character",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.idcharacter[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }

  func name() throws -> String {
    let field = GraphQLField.leaf(
      field: "name",
      parent: "Character",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.namecharacter[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }

  func description() throws -> String {
    let field = GraphQLField.leaf(
      field: "description",
      parent: "Character",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.descriptioncharacter[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }
  /// URL of the character image.

  func image() throws -> String {
    let field = GraphQLField.leaf(
      field: "image",
      parent: "Character",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.imagecharacter[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }
  /// Tells whether currently authenticated user has starred this character.
  /// NOTE: If there's no authenticated user, this field will always return false.

  func starred() throws -> Bool {
    let field = GraphQLField.leaf(
      field: "starred",
      parent: "Character",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.starredcharacter[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return Bool.mockValue
    }
  }
}
extension Selection where TypeLock == Never, Type == Never {
  typealias Character<T> = Selection<T, Objects.Character>
}
extension Objects {
  struct Comic {
    let __typename: TypeName = .comic
    let descriptioncomic: [String: String]
    let idcomic: [String: String]
    let isbncomic: [String: String]
    let pageCountcomic: [String: Int]
    let starredcomic: [String: Bool]
    let thumbnailcomic: [String: String]
    let titlecomic: [String: String]

    enum TypeName: String, Codable {
      case comic = "Comic"
    }
  }
}

extension Objects.Comic: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

    var map = HashMap()
    for codingKey in container.allKeys {
      if codingKey.isTypenameKey { continue }

      let alias = codingKey.stringValue
      let field = GraphQLField.getFieldNameFromAlias(alias)

      switch field {
      case "idcomic":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "titlecomic":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "descriptioncomic":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "isbncomic":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "thumbnailcomic":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "pageCountcomic":
        if let value = try container.decode(Int?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "starredcomic":
        if let value = try container.decode(Bool?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      default:
        throw DecodingError.dataCorrupted(
          DecodingError.Context(
            codingPath: decoder.codingPath,
            debugDescription: "Unknown key \(field)."
          )
        )
      }
    }

    self.idcomic = map["idcomic"]
    self.titlecomic = map["titlecomic"]
    self.descriptioncomic = map["descriptioncomic"]
    self.isbncomic = map["isbncomic"]
    self.thumbnailcomic = map["thumbnailcomic"]
    self.pageCountcomic = map["pageCountcomic"]
    self.starredcomic = map["starredcomic"]
  }
}

extension Fields where TypeLock == Objects.Comic {

  func id() throws -> String {
    let field = GraphQLField.leaf(
      field: "id",
      parent: "Comic",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.idcomic[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }

  func title() throws -> String {
    let field = GraphQLField.leaf(
      field: "title",
      parent: "Comic",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.titlecomic[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }

  func description() throws -> String {
    let field = GraphQLField.leaf(
      field: "description",
      parent: "Comic",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.descriptioncomic[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }

  func isbn() throws -> String {
    let field = GraphQLField.leaf(
      field: "isbn",
      parent: "Comic",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.isbncomic[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }
  /// URL of the thumbnail image.

  func thumbnail() throws -> String {
    let field = GraphQLField.leaf(
      field: "thumbnail",
      parent: "Comic",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.thumbnailcomic[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }

  func pageCount() throws -> Int? {
    let field = GraphQLField.leaf(
      field: "pageCount",
      parent: "Comic",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      return data.pageCountcomic[field.alias!]
    case .mocking:
      return nil
    }
  }
  /// Tells whether currently authenticated user has starred this comic.

  func starred() throws -> Bool {
    let field = GraphQLField.leaf(
      field: "starred",
      parent: "Comic",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.starredcomic[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return Bool.mockValue
    }
  }
}
extension Selection where TypeLock == Never, Type == Never {
  typealias Comic<T> = Selection<T, Objects.Comic>
}
extension Objects {
  struct Mutation {
    let __typename: TypeName = .mutation
    let authmutation: [String: Unions.AuthPayload]
    let starmutation: [String: Unions.SearchResult]
    let uploadFilemutation: [String: Objects.File]

    enum TypeName: String, Codable {
      case mutation = "Mutation"
    }
  }
}

extension Objects.Mutation: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

    var map = HashMap()
    for codingKey in container.allKeys {
      if codingKey.isTypenameKey { continue }

      let alias = codingKey.stringValue
      let field = GraphQLField.getFieldNameFromAlias(alias)

      switch field {
      case "authmutation":
        if let value = try container.decode(Unions.AuthPayload?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "starmutation":
        if let value = try container.decode(Unions.SearchResult?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "uploadFilemutation":
        if let value = try container.decode(Objects.File?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      default:
        throw DecodingError.dataCorrupted(
          DecodingError.Context(
            codingPath: decoder.codingPath,
            debugDescription: "Unknown key \(field)."
          )
        )
      }
    }

    self.authmutation = map["authmutation"]
    self.starmutation = map["starmutation"]
    self.uploadFilemutation = map["uploadFilemutation"]
  }
}

extension Fields where TypeLock == Objects.Mutation {
  /// Creates a random authentication session.

  func auth<T>(selection: Selection<T, Unions.AuthPayload>) throws -> T {
    let field = GraphQLField.composite(
      field: "auth",
      parent: "Mutation",
      type: "AuthPayload",
      arguments: [],
      selection: selection.__selection()
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.authmutation[field.alias!] {
        return try selection.__decode(data: data)
      }
      throw SelectionError.badpayload
    case .mocking:
      return try selection.__mock()
    }
  }
  /// Adds a star to a comic or a character.

  func star<T>(id: String, item: Enums.Item, selection: Selection<T, Unions.SearchResult>) throws
    -> T
  {
    let field = GraphQLField.composite(
      field: "star",
      parent: "Mutation",
      type: "SearchResult",
      arguments: [
        Argument(name: "id", type: "ID!", value: id),
        Argument(name: "item", type: "Item!", value: item),
      ],
      selection: selection.__selection()
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.starmutation[field.alias!] {
        return try selection.__decode(data: data)
      }
      throw SelectionError.badpayload
    case .mocking:
      return try selection.__mock()
    }
  }
  /// Creates a new upload URL for a file and returns an ID.
  /// NOTE: The file should be uploaded to the returned URL. If the user is not
  /// authenticated, mutation will throw an error.

  func uploadFile<T>(
    contentType: String, `extension`: OptionalArgument<String> = .init(), folder: String,
    selection: Selection<T, Objects.File>
  ) throws -> T {
    let field = GraphQLField.composite(
      field: "uploadFile",
      parent: "Mutation",
      type: "File",
      arguments: [
        Argument(name: "contentType", type: "String!", value: contentType),
        Argument(name: "extension", type: "String", value: `extension`),
        Argument(name: "folder", type: "String!", value: folder),
      ],
      selection: selection.__selection()
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.uploadFilemutation[field.alias!] {
        return try selection.__decode(data: data)
      }
      throw SelectionError.badpayload
    case .mocking:
      return try selection.__mock()
    }
  }
}
extension Selection where TypeLock == Never, Type == Never {
  typealias Mutation<T> = Selection<T, Objects.Mutation>
}
extension Objects {
  struct AuthPayloadSuccess {
    let __typename: TypeName = .authPayloadSuccess
    let tokenauthPayloadSuccess: [String: String]
    let userauthPayloadSuccess: [String: Objects.User]

    enum TypeName: String, Codable {
      case authPayloadSuccess = "AuthPayloadSuccess"
    }
  }
}

extension Objects.AuthPayloadSuccess: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

    var map = HashMap()
    for codingKey in container.allKeys {
      if codingKey.isTypenameKey { continue }

      let alias = codingKey.stringValue
      let field = GraphQLField.getFieldNameFromAlias(alias)

      switch field {
      case "tokenauthPayloadSuccess":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "userauthPayloadSuccess":
        if let value = try container.decode(Objects.User?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      default:
        throw DecodingError.dataCorrupted(
          DecodingError.Context(
            codingPath: decoder.codingPath,
            debugDescription: "Unknown key \(field)."
          )
        )
      }
    }

    self.tokenauthPayloadSuccess = map["tokenauthPayloadSuccess"]
    self.userauthPayloadSuccess = map["userauthPayloadSuccess"]
  }
}

extension Fields where TypeLock == Objects.AuthPayloadSuccess {

  func token() throws -> String {
    let field = GraphQLField.leaf(
      field: "token",
      parent: "AuthPayloadSuccess",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.tokenauthPayloadSuccess[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }

  func user<T>(selection: Selection<T, Objects.User>) throws -> T {
    let field = GraphQLField.composite(
      field: "user",
      parent: "AuthPayloadSuccess",
      type: "User",
      arguments: [],
      selection: selection.__selection()
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.userauthPayloadSuccess[field.alias!] {
        return try selection.__decode(data: data)
      }
      throw SelectionError.badpayload
    case .mocking:
      return try selection.__mock()
    }
  }
}
extension Selection where TypeLock == Never, Type == Never {
  typealias AuthPayloadSuccess<T> = Selection<T, Objects.AuthPayloadSuccess>
}
extension Objects {
  struct AuthPayloadFailure {
    let __typename: TypeName = .authPayloadFailure
    let messageauthPayloadFailure: [String: String]

    enum TypeName: String, Codable {
      case authPayloadFailure = "AuthPayloadFailure"
    }
  }
}

extension Objects.AuthPayloadFailure: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

    var map = HashMap()
    for codingKey in container.allKeys {
      if codingKey.isTypenameKey { continue }

      let alias = codingKey.stringValue
      let field = GraphQLField.getFieldNameFromAlias(alias)

      switch field {
      case "messageauthPayloadFailure":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      default:
        throw DecodingError.dataCorrupted(
          DecodingError.Context(
            codingPath: decoder.codingPath,
            debugDescription: "Unknown key \(field)."
          )
        )
      }
    }

    self.messageauthPayloadFailure = map["messageauthPayloadFailure"]
  }
}

extension Fields where TypeLock == Objects.AuthPayloadFailure {

  func message() throws -> String {
    let field = GraphQLField.leaf(
      field: "message",
      parent: "AuthPayloadFailure",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.messageauthPayloadFailure[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }
}
extension Selection where TypeLock == Never, Type == Never {
  typealias AuthPayloadFailure<T> = Selection<T, Objects.AuthPayloadFailure>
}
extension Objects {
  struct File {
    let __typename: TypeName = .file
    let idfile: [String: String]
    let publicUrlfile: [String: String]
    let uploadUrlfile: [String: String]

    enum TypeName: String, Codable {
      case file = "File"
    }
  }
}

extension Objects.File: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

    var map = HashMap()
    for codingKey in container.allKeys {
      if codingKey.isTypenameKey { continue }

      let alias = codingKey.stringValue
      let field = GraphQLField.getFieldNameFromAlias(alias)

      switch field {
      case "idfile":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "uploadUrlfile":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "publicUrlfile":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      default:
        throw DecodingError.dataCorrupted(
          DecodingError.Context(
            codingPath: decoder.codingPath,
            debugDescription: "Unknown key \(field)."
          )
        )
      }
    }

    self.idfile = map["idfile"]
    self.uploadUrlfile = map["uploadUrlfile"]
    self.publicUrlfile = map["publicUrlfile"]
  }
}

extension Fields where TypeLock == Objects.File {

  func id() throws -> String {
    let field = GraphQLField.leaf(
      field: "id",
      parent: "File",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.idfile[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }
  /// Signed URL that should be used to upload the file.

  func uploadUrl() throws -> String {
    let field = GraphQLField.leaf(
      field: "uploadUrl",
      parent: "File",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.uploadUrlfile[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }
  /// URL that may be used to access the file.

  func publicUrl() throws -> String {
    let field = GraphQLField.leaf(
      field: "publicUrl",
      parent: "File",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.publicUrlfile[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }
}
extension Selection where TypeLock == Never, Type == Never {
  typealias File<T> = Selection<T, Objects.File>
}
extension Objects {
  struct Subscription {
    let __typename: TypeName = .subscription

    enum TypeName: String, Codable {
      case subscription = "Subscription"
    }
  }
}

extension Objects.Subscription: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

    var map = HashMap()
    for codingKey in container.allKeys {
      if codingKey.isTypenameKey { continue }

      let alias = codingKey.stringValue
      let field = GraphQLField.getFieldNameFromAlias(alias)

      switch field {

      default:
        throw DecodingError.dataCorrupted(
          DecodingError.Context(
            codingPath: decoder.codingPath,
            debugDescription: "Unknown key \(field)."
          )
        )
      }
    }

  }
}

extension Fields where TypeLock == Objects.Subscription {

}

extension Objects {
  struct Message {
    let __typename: TypeName = .message
    let authormessage: [String: Objects.User]
    let idmessage: [String: String]
    let imagemessage: [String: Objects.File]
    let messagemessage: [String: String]

    enum TypeName: String, Codable {
      case message = "Message"
    }
  }
}

extension Objects.Message: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

    var map = HashMap()
    for codingKey in container.allKeys {
      if codingKey.isTypenameKey { continue }

      let alias = codingKey.stringValue
      let field = GraphQLField.getFieldNameFromAlias(alias)

      switch field {
      case "idmessage":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "messagemessage":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "imagemessage":
        if let value = try container.decode(Objects.File?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "authormessage":
        if let value = try container.decode(Objects.User?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      default:
        throw DecodingError.dataCorrupted(
          DecodingError.Context(
            codingPath: decoder.codingPath,
            debugDescription: "Unknown key \(field)."
          )
        )
      }
    }

    self.idmessage = map["idmessage"]
    self.messagemessage = map["messagemessage"]
    self.imagemessage = map["imagemessage"]
    self.authormessage = map["authormessage"]
  }
}

extension Fields where TypeLock == Objects.Message {

  func id() throws -> String {
    let field = GraphQLField.leaf(
      field: "id",
      parent: "Message",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.idmessage[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }

  func message() throws -> String {
    let field = GraphQLField.leaf(
      field: "message",
      parent: "Message",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.messagemessage[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }

  func image<T>(selection: Selection<T, Objects.File>) throws -> T {
    let field = GraphQLField.composite(
      field: "image",
      parent: "Message",
      type: "File",
      arguments: [],
      selection: selection.__selection()
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.imagemessage[field.alias!] {
        return try selection.__decode(data: data)
      }
      throw SelectionError.badpayload
    case .mocking:
      return try selection.__mock()
    }
  }

  func author<T>(selection: Selection<T, Objects.User>) throws -> T {
    let field = GraphQLField.composite(
      field: "author",
      parent: "Message",
      type: "User",
      arguments: [],
      selection: selection.__selection()
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.authormessage[field.alias!] {
        return try selection.__decode(data: data)
      }
      throw SelectionError.badpayload
    case .mocking:
      return try selection.__mock()
    }
  }
}
extension Selection where TypeLock == Never, Type == Never {
  typealias Message<T> = Selection<T, Objects.Message>
}
extension Objects.User {

  static func id() throws -> Selection<String, Objects.User> {
    Selection<String, Objects.User> {
      try $0.id()
    }
  }
  /// A nickname user has picked for themself.

  static func username() throws -> Selection<String, Objects.User> {
    Selection<String, Objects.User> {
      try $0.username()
    }
  }
}

extension Objects.Query {
  /// Simple field that always returns "Hello world!".

  static func hello() throws -> Selection<String, Objects.Query> {
    Selection<String, Objects.Query> {
      try $0.hello()
    }
  }
  /// Returns currently authenticated user and errors if there's no authenticated user.

  static func user<T>(selection: Selection<T, Objects.User>) throws -> Selection<T, Objects.Query> {
    Selection<T, Objects.Query> {
      try $0.user(selection: selection)
    }
  }
  /// Returns a list of comics from the Marvel universe.

  static func comics<T>(
    pagination: OptionalArgument<InputObjects.Pagination> = .init(),
    selection: Selection<T, [Objects.Comic]>
  ) throws -> Selection<T, Objects.Query> {
    Selection<T, Objects.Query> {
      try $0.comics(pagination: pagination, selection: selection)
    }
  }
  /// Returns a list of characters from the Marvel universe.

  static func characters<T>(
    pagination: OptionalArgument<InputObjects.Pagination> = .init(),
    selection: Selection<T, [Objects.Character]>
  ) throws -> Selection<T, Objects.Query> {
    Selection<T, Objects.Query> {
      try $0.characters(pagination: pagination, selection: selection)
    }
  }
  /// Searches all characters and comics by name and returns those whose
  /// name starts with the query string.

  static func search<T>(
    query: InputObjects.Search, pagination: OptionalArgument<InputObjects.Pagination> = .init(),
    selection: Selection<T, [Unions.SearchResult]>
  ) throws -> Selection<T, Objects.Query> {
    Selection<T, Objects.Query> {
      try $0.search(query: query, pagination: pagination, selection: selection)
    }
  }
}

extension Objects.Character {

  static func id() throws -> Selection<String, Objects.Character> {
    Selection<String, Objects.Character> {
      try $0.id()
    }
  }

  static func name() throws -> Selection<String, Objects.Character> {
    Selection<String, Objects.Character> {
      try $0.name()
    }
  }

  static func description() throws -> Selection<String, Objects.Character> {
    Selection<String, Objects.Character> {
      try $0.description()
    }
  }
  /// URL of the character image.

  static func image() throws -> Selection<String, Objects.Character> {
    Selection<String, Objects.Character> {
      try $0.image()
    }
  }
  /// Tells whether currently authenticated user has starred this character.
  /// NOTE: If there's no authenticated user, this field will always return false.

  static func starred() throws -> Selection<Bool, Objects.Character> {
    Selection<Bool, Objects.Character> {
      try $0.starred()
    }
  }
}

extension Objects.Comic {

  static func id() throws -> Selection<String, Objects.Comic> {
    Selection<String, Objects.Comic> {
      try $0.id()
    }
  }

  static func title() throws -> Selection<String, Objects.Comic> {
    Selection<String, Objects.Comic> {
      try $0.title()
    }
  }

  static func description() throws -> Selection<String, Objects.Comic> {
    Selection<String, Objects.Comic> {
      try $0.description()
    }
  }

  static func isbn() throws -> Selection<String, Objects.Comic> {
    Selection<String, Objects.Comic> {
      try $0.isbn()
    }
  }
  /// URL of the thumbnail image.

  static func thumbnail() throws -> Selection<String, Objects.Comic> {
    Selection<String, Objects.Comic> {
      try $0.thumbnail()
    }
  }

  static func pageCount() throws -> Selection<Int?, Objects.Comic> {
    Selection<Int?, Objects.Comic> {
      try $0.pageCount()
    }
  }
  /// Tells whether currently authenticated user has starred this comic.

  static func starred() throws -> Selection<Bool, Objects.Comic> {
    Selection<Bool, Objects.Comic> {
      try $0.starred()
    }
  }
}

extension Objects.Mutation {
  /// Creates a random authentication session.

  static func auth<T>(selection: Selection<T, Unions.AuthPayload>) throws -> Selection<
    T, Objects.Mutation
  > {
    Selection<T, Objects.Mutation> {
      try $0.auth(selection: selection)
    }
  }
  /// Adds a star to a comic or a character.

  static func star<T>(id: String, item: Enums.Item, selection: Selection<T, Unions.SearchResult>)
    throws -> Selection<T, Objects.Mutation>
  {
    Selection<T, Objects.Mutation> {
      try $0.star(id: id, item: item, selection: selection)
    }
  }
  /// Creates a new upload URL for a file and returns an ID.
  /// NOTE: The file should be uploaded to the returned URL. If the user is not
  /// authenticated, mutation will throw an error.

  static func uploadFile<T>(
    contentType: String, `extension`: OptionalArgument<String> = .init(), folder: String,
    selection: Selection<T, Objects.File>
  ) throws -> Selection<T, Objects.Mutation> {
    Selection<T, Objects.Mutation> {
      try $0.uploadFile(
        contentType: contentType, `extension`: `extension`, folder: folder, selection: selection)
    }
  }
}

extension Objects.AuthPayloadSuccess {

  static func token() throws -> Selection<String, Objects.AuthPayloadSuccess> {
    Selection<String, Objects.AuthPayloadSuccess> {
      try $0.token()
    }
  }

  static func user<T>(selection: Selection<T, Objects.User>) throws -> Selection<
    T, Objects.AuthPayloadSuccess
  > {
    Selection<T, Objects.AuthPayloadSuccess> {
      try $0.user(selection: selection)
    }
  }
}

extension Objects.AuthPayloadFailure {

  static func message() throws -> Selection<String, Objects.AuthPayloadFailure> {
    Selection<String, Objects.AuthPayloadFailure> {
      try $0.message()
    }
  }
}

extension Objects.File {

  static func id() throws -> Selection<String, Objects.File> {
    Selection<String, Objects.File> {
      try $0.id()
    }
  }
  /// Signed URL that should be used to upload the file.

  static func uploadUrl() throws -> Selection<String, Objects.File> {
    Selection<String, Objects.File> {
      try $0.uploadUrl()
    }
  }
  /// URL that may be used to access the file.

  static func publicUrl() throws -> Selection<String, Objects.File> {
    Selection<String, Objects.File> {
      try $0.publicUrl()
    }
  }
}

extension Objects.Subscription {

}
extension Selection where TypeLock == Never, Type == Never {
  typealias Subscription = Objects.Subscription
}
extension Objects.Message {

  static func id() throws -> Selection<String, Objects.Message> {
    Selection<String, Objects.Message> {
      try $0.id()
    }
  }

  static func message() throws -> Selection<String, Objects.Message> {
    Selection<String, Objects.Message> {
      try $0.message()
    }
  }

  static func image<T>(selection: Selection<T, Objects.File>) throws -> Selection<
    T, Objects.Message
  > {
    Selection<T, Objects.Message> {
      try $0.image(selection: selection)
    }
  }

  static func author<T>(selection: Selection<T, Objects.User>) throws -> Selection<
    T, Objects.Message
  > {
    Selection<T, Objects.Message> {
      try $0.author(selection: selection)
    }
  }
}

// MARK: - Interfaces
enum Interfaces {}
extension Interfaces {
  struct Node {
    let __typename: TypeName
    let authormessage: [String: Objects.User]
    let descriptioncharacter: [String: String]
    let descriptioncomic: [String: String]
    let idnode: [String: String]
    let iduser: [String: String]
    let idcharacter: [String: String]
    let idcomic: [String: String]
    let idfile: [String: String]
    let idmessage: [String: String]
    let imagecharacter: [String: String]
    let imagemessage: [String: Objects.File]
    let isbncomic: [String: String]
    let messagemessage: [String: String]
    let namecharacter: [String: String]
    let pageCountcomic: [String: Int]
    let publicUrlfile: [String: String]
    let starredcharacter: [String: Bool]
    let starredcomic: [String: Bool]
    let thumbnailcomic: [String: String]
    let titlecomic: [String: String]
    let uploadUrlfile: [String: String]
    let usernameuser: [String: String]

    enum TypeName: String, Codable {
      case user = "User"
      case character = "Character"
      case comic = "Comic"
      case file = "File"
      case message = "Message"
    }
  }
}

extension Interfaces.Node: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

    var map = HashMap()
    for codingKey in container.allKeys {
      if codingKey.isTypenameKey { continue }

      let alias = codingKey.stringValue
      let field = GraphQLField.getFieldNameFromAlias(alias)

      switch field {
      case "idnode":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "iduser":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "usernameuser":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "idcharacter":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "namecharacter":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "descriptioncharacter":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "imagecharacter":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "starredcharacter":
        if let value = try container.decode(Bool?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "idcomic":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "titlecomic":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "descriptioncomic":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "isbncomic":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "thumbnailcomic":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "pageCountcomic":
        if let value = try container.decode(Int?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "starredcomic":
        if let value = try container.decode(Bool?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "idfile":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "uploadUrlfile":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "publicUrlfile":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "idmessage":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "messagemessage":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "imagemessage":
        if let value = try container.decode(Objects.File?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "authormessage":
        if let value = try container.decode(Objects.User?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      default:
        throw DecodingError.dataCorrupted(
          DecodingError.Context(
            codingPath: decoder.codingPath,
            debugDescription: "Unknown key \(field)."
          )
        )
      }
    }

    self.__typename = try container.decode(
      TypeName.self, forKey: DynamicCodingKeys(stringValue: "__typename")!)

    self.idnode = map["idnode"]
    self.iduser = map["iduser"]
    self.usernameuser = map["usernameuser"]
    self.idcharacter = map["idcharacter"]
    self.namecharacter = map["namecharacter"]
    self.descriptioncharacter = map["descriptioncharacter"]
    self.imagecharacter = map["imagecharacter"]
    self.starredcharacter = map["starredcharacter"]
    self.idcomic = map["idcomic"]
    self.titlecomic = map["titlecomic"]
    self.descriptioncomic = map["descriptioncomic"]
    self.isbncomic = map["isbncomic"]
    self.thumbnailcomic = map["thumbnailcomic"]
    self.pageCountcomic = map["pageCountcomic"]
    self.starredcomic = map["starredcomic"]
    self.idfile = map["idfile"]
    self.uploadUrlfile = map["uploadUrlfile"]
    self.publicUrlfile = map["publicUrlfile"]
    self.idmessage = map["idmessage"]
    self.messagemessage = map["messagemessage"]
    self.imagemessage = map["imagemessage"]
    self.authormessage = map["authormessage"]
  }
}

extension Fields where TypeLock == Interfaces.Node {
  /// ID of the object.

  func id() throws -> String {
    let field = GraphQLField.leaf(
      field: "id",
      parent: "Node",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding(let data):
      if let data = data.idnode[field.alias!] {
        return data
      }
      throw SelectionError.badpayload
    case .mocking:
      return String.mockValue
    }
  }
}

extension Fields where TypeLock == Interfaces.Node {
  func on<T>(
    user: Selection<T, Objects.User>, character: Selection<T, Objects.Character>,
    comic: Selection<T, Objects.Comic>, file: Selection<T, Objects.File>,
    message: Selection<T, Objects.Message>
  ) throws -> T {
    self.__select([
      GraphQLField.fragment(
        type: "User", interface: "Interfaces.Node", selection: user.__selection()),
      GraphQLField.fragment(
        type: "Character", interface: "Interfaces.Node", selection: character.__selection()),
      GraphQLField.fragment(
        type: "Comic", interface: "Interfaces.Node", selection: comic.__selection()),
      GraphQLField.fragment(
        type: "File", interface: "Interfaces.Node", selection: file.__selection()),
      GraphQLField.fragment(
        type: "Message", interface: "Interfaces.Node", selection: message.__selection()),
    ])

    switch self.__state {
    case .decoding(let data):
      switch data.__typename {
      case .user:
        let data = Objects.User(iduser: data.iduser, usernameuser: data.usernameuser)
        return try user.__decode(data: data)
      case .character:
        let data = Objects.Character(
          descriptioncharacter: data.descriptioncharacter, idcharacter: data.idcharacter,
          imagecharacter: data.imagecharacter, namecharacter: data.namecharacter,
          starredcharacter: data.starredcharacter)
        return try character.__decode(data: data)
      case .comic:
        let data = Objects.Comic(
          descriptioncomic: data.descriptioncomic, idcomic: data.idcomic, isbncomic: data.isbncomic,
          pageCountcomic: data.pageCountcomic, starredcomic: data.starredcomic,
          thumbnailcomic: data.thumbnailcomic, titlecomic: data.titlecomic)
        return try comic.__decode(data: data)
      case .file:
        let data = Objects.File(
          idfile: data.idfile, publicUrlfile: data.publicUrlfile, uploadUrlfile: data.uploadUrlfile)
        return try file.__decode(data: data)
      case .message:
        let data = Objects.Message(
          authormessage: data.authormessage, idmessage: data.idmessage,
          imagemessage: data.imagemessage, messagemessage: data.messagemessage)
        return try message.__decode(data: data)
      }
    case .mocking:
      return try user.__mock()
    }
  }
}

extension Selection where TypeLock == Never, Type == Never {
  typealias Node<T> = Selection<T, Interfaces.Node>
}

// MARK: - Unions
enum Unions {}
extension Unions {
  struct SearchResult {
    let __typename: TypeName
    let descriptioncharacter: [String: String]
    let descriptioncomic: [String: String]
    let idcharacter: [String: String]
    let idcomic: [String: String]
    let imagecharacter: [String: String]
    let isbncomic: [String: String]
    let namecharacter: [String: String]
    let pageCountcomic: [String: Int]
    let starredcharacter: [String: Bool]
    let starredcomic: [String: Bool]
    let thumbnailcomic: [String: String]
    let titlecomic: [String: String]

    enum TypeName: String, Codable {
      case character = "Character"
      case comic = "Comic"
    }
  }
}

extension Unions.SearchResult: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

    var map = HashMap()
    for codingKey in container.allKeys {
      if codingKey.isTypenameKey { continue }

      let alias = codingKey.stringValue
      let field = GraphQLField.getFieldNameFromAlias(alias)

      switch field {
      case "idcharacter":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "namecharacter":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "descriptioncharacter":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "imagecharacter":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "starredcharacter":
        if let value = try container.decode(Bool?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "idcomic":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "titlecomic":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "descriptioncomic":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "isbncomic":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "thumbnailcomic":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "pageCountcomic":
        if let value = try container.decode(Int?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "starredcomic":
        if let value = try container.decode(Bool?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      default:
        throw DecodingError.dataCorrupted(
          DecodingError.Context(
            codingPath: decoder.codingPath,
            debugDescription: "Unknown key \(field)."
          )
        )
      }
    }

    self.__typename = try container.decode(
      TypeName.self, forKey: DynamicCodingKeys(stringValue: "__typename")!)

    self.idcharacter = map["idcharacter"]
    self.namecharacter = map["namecharacter"]
    self.descriptioncharacter = map["descriptioncharacter"]
    self.imagecharacter = map["imagecharacter"]
    self.starredcharacter = map["starredcharacter"]
    self.idcomic = map["idcomic"]
    self.titlecomic = map["titlecomic"]
    self.descriptioncomic = map["descriptioncomic"]
    self.isbncomic = map["isbncomic"]
    self.thumbnailcomic = map["thumbnailcomic"]
    self.pageCountcomic = map["pageCountcomic"]
    self.starredcomic = map["starredcomic"]
  }
}

extension Fields where TypeLock == Unions.SearchResult {
  func on<T>(character: Selection<T, Objects.Character>, comic: Selection<T, Objects.Comic>) throws
    -> T
  {
    self.__select([
      GraphQLField.fragment(
        type: "Character", interface: "Unions.SearchResult", selection: character.__selection()),
      GraphQLField.fragment(
        type: "Comic", interface: "Unions.SearchResult", selection: comic.__selection()),
    ])

    switch self.__state {
    case .decoding(let data):
      switch data.__typename {
      case .character:
        let data = Objects.Character(
          descriptioncharacter: data.descriptioncharacter, idcharacter: data.idcharacter,
          imagecharacter: data.imagecharacter, namecharacter: data.namecharacter,
          starredcharacter: data.starredcharacter)
        return try character.__decode(data: data)
      case .comic:
        let data = Objects.Comic(
          descriptioncomic: data.descriptioncomic, idcomic: data.idcomic, isbncomic: data.isbncomic,
          pageCountcomic: data.pageCountcomic, starredcomic: data.starredcomic,
          thumbnailcomic: data.thumbnailcomic, titlecomic: data.titlecomic)
        return try comic.__decode(data: data)
      }
    case .mocking:
      return try character.__mock()
    }
  }
}

extension Selection where TypeLock == Never, Type == Never {
  typealias SearchResult<T> = Selection<T, Unions.SearchResult>
}
extension Unions {
  struct AuthPayload {
    let __typename: TypeName
    let messageauthPayloadFailure: [String: String]
    let tokenauthPayloadSuccess: [String: String]
    let userauthPayloadSuccess: [String: Objects.User]

    enum TypeName: String, Codable {
      case authPayloadSuccess = "AuthPayloadSuccess"
      case authPayloadFailure = "AuthPayloadFailure"
    }
  }
}

extension Unions.AuthPayload: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

    var map = HashMap()
    for codingKey in container.allKeys {
      if codingKey.isTypenameKey { continue }

      let alias = codingKey.stringValue
      let field = GraphQLField.getFieldNameFromAlias(alias)

      switch field {
      case "tokenauthPayloadSuccess":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "userauthPayloadSuccess":
        if let value = try container.decode(Objects.User?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      case "messageauthPayloadFailure":
        if let value = try container.decode(String?.self, forKey: codingKey) {
          map.set(key: field, hash: alias, value: value as Any)
        }
      default:
        throw DecodingError.dataCorrupted(
          DecodingError.Context(
            codingPath: decoder.codingPath,
            debugDescription: "Unknown key \(field)."
          )
        )
      }
    }

    self.__typename = try container.decode(
      TypeName.self, forKey: DynamicCodingKeys(stringValue: "__typename")!)

    self.tokenauthPayloadSuccess = map["tokenauthPayloadSuccess"]
    self.userauthPayloadSuccess = map["userauthPayloadSuccess"]
    self.messageauthPayloadFailure = map["messageauthPayloadFailure"]
  }
}

extension Fields where TypeLock == Unions.AuthPayload {
  func on<T>(
    authPayloadSuccess: Selection<T, Objects.AuthPayloadSuccess>,
    authPayloadFailure: Selection<T, Objects.AuthPayloadFailure>
  ) throws -> T {
    self.__select([
      GraphQLField.fragment(
        type: "AuthPayloadSuccess", interface: "Unions.AuthPayload",
        selection: authPayloadSuccess.__selection()),
      GraphQLField.fragment(
        type: "AuthPayloadFailure", interface: "Unions.AuthPayload",
        selection: authPayloadFailure.__selection()),
    ])

    switch self.__state {
    case .decoding(let data):
      switch data.__typename {
      case .authPayloadSuccess:
        let data = Objects.AuthPayloadSuccess(
          tokenauthPayloadSuccess: data.tokenauthPayloadSuccess,
          userauthPayloadSuccess: data.userauthPayloadSuccess)
        return try authPayloadSuccess.__decode(data: data)
      case .authPayloadFailure:
        let data = Objects.AuthPayloadFailure(
          messageauthPayloadFailure: data.messageauthPayloadFailure)
        return try authPayloadFailure.__decode(data: data)
      }
    case .mocking:
      return try authPayloadSuccess.__mock()
    }
  }
}

extension Selection where TypeLock == Never, Type == Never {
  typealias AuthPayload<T> = Selection<T, Unions.AuthPayload>
}

// MARK: - Enums
enum Enums {}
extension Enums {
  /// Item
  enum Item: String, CaseIterable, Codable {

    case character = "CHARACTER"

    case comic = "COMIC"
  }
}

// MARK: - Input Objects

/// Utility pointer to InputObjects.
typealias Inputs = InputObjects

enum InputObjects {}
extension InputObjects {
  struct Pagination: Encodable, Hashable {

    var offset: OptionalArgument<Int> = .init()
    /// Number of items in a list that should be returned.
    /// NOTE: Maximum is 20 items.
    var take: OptionalArgument<Int> = .init()

    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      if offset.hasValue { try container.encode(offset, forKey: .offset) }
      if take.hasValue { try container.encode(take, forKey: .take) }
    }

    enum CodingKeys: String, CodingKey {
      case offset = "offset"
      case take = "take"
    }
  }
}
extension InputObjects {
  struct Search: Encodable, Hashable {

    /// String used to compare the name of the item to.
    var query: String

    var pagination: OptionalArgument<InputObjects.Pagination> = .init()

    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(query, forKey: .query)
      if pagination.hasValue { try container.encode(pagination, forKey: .pagination) }
    }

    enum CodingKeys: String, CodingKey {
      case query = "query"
      case pagination = "pagination"
    }
  }
}
