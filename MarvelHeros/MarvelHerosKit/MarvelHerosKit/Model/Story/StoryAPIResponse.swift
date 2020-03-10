import Foundation

/// Holds the API response of stories list inside marvel character
public struct StoriesAPIResponse: Codable {
    
    // MARK: - Properties
    public let available: Int
    public let items: [Story]
}
