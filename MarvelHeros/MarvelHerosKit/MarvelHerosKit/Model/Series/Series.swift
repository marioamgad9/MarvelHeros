import Foundation

/// Holds the value of a single marvel series
public struct Series: Codable {
    
    // MARK: - Properties
    public let name: String
    public let resourceURI: URL
}
