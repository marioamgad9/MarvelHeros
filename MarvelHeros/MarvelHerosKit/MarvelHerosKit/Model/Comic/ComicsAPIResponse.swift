import Foundation

/// Holds the API response of comics list inside marvel character
public struct ComicsAPIResponse: Codable {
    
    // MARK: - Properties
    public let data: ComicsData
}
