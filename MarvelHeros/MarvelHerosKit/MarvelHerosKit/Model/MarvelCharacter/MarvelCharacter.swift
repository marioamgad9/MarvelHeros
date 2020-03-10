import Foundation

/// Holds the value of a single marvel character
public struct MarvelCharacter: Codable {
    
    // MARK: - Properties
    public let id: Int
    public let name: String
    public let description: String
    public let comics: ComicsAPIResponse
    public let series: SeriesAPIResponse
    public let stories: StoriesAPIResponse
}
