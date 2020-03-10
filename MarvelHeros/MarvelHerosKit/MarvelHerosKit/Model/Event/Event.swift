import Foundation

/// Holds the value of a single event
public struct Event: Codable {
    
    // MARK: - Properties
    public let name: String
    public let resourceURI: URL
}
