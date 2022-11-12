// swiftlint:disable all
import Amplify
import Foundation

public struct Message: Model {
  public let id: String
  public var user: String?
  public var text: String?
  public var received: Bool?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      user: String? = nil,
      text: String? = nil,
      received: Bool? = nil) {
    self.init(id: id,
      user: user,
      text: text,
      received: received,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      user: String? = nil,
      text: String? = nil,
      received: Bool? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.user = user
      self.text = text
      self.received = received
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}

extension Message : Identifiable {
    
}
