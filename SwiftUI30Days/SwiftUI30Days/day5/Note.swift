// swiftlint:disable all
import Amplify
import Foundation

public struct Note: Model {
  public let id: String
  public var DocumentTitle: String?
  public var DocumentExcerpt: String?
  public var DocumentURI: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      DocumentTitle: String? = nil,
      DocumentExcerpt: String? = nil,
      DocumentURI: String? = nil) {
    self.init(id: id,
      DocumentTitle: DocumentTitle,
      DocumentExcerpt: DocumentExcerpt,
      DocumentURI: DocumentURI,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      DocumentTitle: String? = nil,
      DocumentExcerpt: String? = nil,
      DocumentURI: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.DocumentTitle = DocumentTitle
      self.DocumentExcerpt = DocumentExcerpt
      self.DocumentURI = DocumentURI
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}