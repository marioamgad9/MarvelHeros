import Foundation

/// Holds the value of a single marvel story
public struct Story: Codable {
    
    // MARK: - Properties
    public let name: String
    public let type: String
    public let resourceURI: URL
}
