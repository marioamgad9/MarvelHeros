import Foundation

/// Holds the value of a single marvel comic
public struct Comic: Codable {
    
    // MARK: - Properties
    public let name: String
    public let resourceURI: URL
}
