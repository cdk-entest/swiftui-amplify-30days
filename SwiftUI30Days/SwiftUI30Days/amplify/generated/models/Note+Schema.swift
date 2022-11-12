// swiftlint:disable all
import Amplify
import Foundation

extension Note {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case DocumentTitle
    case DocumentExcerpt
    case DocumentURI
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let note = Note.keys
    
    model.pluralName = "Notes"
    
    model.fields(
      .id(),
      .field(note.DocumentTitle, is: .optional, ofType: .string),
      .field(note.DocumentExcerpt, is: .optional, ofType: .string),
      .field(note.DocumentURI, is: .optional, ofType: .string),
      .field(note.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(note.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}