import Foundation

/// Holds the value of a single marvel series
public struct Series: Codable {
    
    // MARK: - Properties
    public let id: Int
    public let title: String
    public let thumbnail: Thumbnail
}
