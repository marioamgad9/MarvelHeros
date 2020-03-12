import Foundation

/// Holds the value of a single marvel character
public struct MarvelCharacter: Codable {
    
    // MARK: - Properties
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnail: Thumbnail
    public let comics: ComicsAPIResponse
    public let series: SeriesAPIResponse
    public let stories: StoriesAPIResponse
    public let events: EventsAPIResponse
    
    // Mark: - Empty instance
    public static let empty: MarvelCharacter = {
        MarvelCharacter(id: 0, name: "", description: "",
                        thumbnail: Thumbnail(path: "", fileExtension: ""),
                        comics: ComicsAPIResponse(available: 0, items: []),
                        series: SeriesAPIResponse(available: 0, items: []),
                        stories: StoriesAPIResponse(available: 0, items: []),
                        events: EventsAPIResponse(available: 0, items: []))
    }()
}
