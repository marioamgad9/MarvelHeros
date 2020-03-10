import Foundation

/// Holds the API response of marvel characters list
public struct MarvelCharactersAPIResponse: Codable {
    
    // MARK: - Empty instance
    public static let empty = MarvelCharactersAPIResponse(data: MarvelCharactersData(offset: 0,
                                                                                     limit: 0, 
                                                                                     total: 0, 
                                                                                     count: 0, 
                                                                                     results: []))
    
    // MARK: - Properties
    public let data: MarvelCharactersData
}
