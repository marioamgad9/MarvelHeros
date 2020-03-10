import Foundation

/// Holds the API response of series list inside marvel character
public struct SeriesAPIResponse: Codable {
    
    // MARK: - Properties
    public let available: Int
    public let items: [Series]
}
