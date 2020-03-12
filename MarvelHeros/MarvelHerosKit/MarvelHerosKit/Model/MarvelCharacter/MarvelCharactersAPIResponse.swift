import Foundation

/// Holds the API response of marvel characters list
public struct MarvelCharactersAPIResponse: Codable {
    
    // MARK: - Properties
    public let data: MarvelCharactersData
}
