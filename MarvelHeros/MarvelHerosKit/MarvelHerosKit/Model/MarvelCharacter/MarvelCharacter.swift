import Foundation

/// Holds the value of a single marvel character
public struct MarvelCharacter: Codable {
    
    // MARK: - Properties
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnail: Thumbnail
    
    // Mark: - Empty instance
    public static let empty: MarvelCharacter = {
        MarvelCharacter(id: 0, name: "", description: "",
                        thumbnail: Thumbnail(path: "", fileExtension: ""))
    }()
}
