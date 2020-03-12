import Foundation

/// Holds the API response of comics list inside marvel character
public struct ComicsAPIResponse: Codable {
    
    // MARK: - Empty instance
    public static let empty = ComicsAPIResponse(data: ComicsData(offset: 0,
                                                                 limit: 0,
                                                                 total: 0,
                                                                 count: 0,
                                                                 results: []))
    
    // MARK: - Properties
    public let data: ComicsData
}
