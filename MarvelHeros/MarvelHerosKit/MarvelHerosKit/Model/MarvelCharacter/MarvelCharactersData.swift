import Foundation

/// Holds the offset, limit, total, and count info of the marvel characters list
public struct MarvelCharactersData: Codable {
    
    // MARK: - Properties
    public let offset: Int
    public let limit: Int
    public let total: Int
    public let count: Int
    public let results: [MarvelCharacter]
}
