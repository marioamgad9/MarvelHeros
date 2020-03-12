import Foundation

/// Holds the value of a single marvel comic
public struct Comic: Codable {
    
    // MARK: - Properties
    public let id: Int
    public let title: String
    public let thumbnail: Thumbnail
}
