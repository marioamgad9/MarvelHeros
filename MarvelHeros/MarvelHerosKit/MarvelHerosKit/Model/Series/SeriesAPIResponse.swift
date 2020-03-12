import Foundation

/// Holds the API response of comics list inside marvel character
public struct SeriesAPIResponse: Codable {
    
    // MARK: - Properties
    public let data: SeriesData
}
