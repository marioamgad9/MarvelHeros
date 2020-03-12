import Foundation

/// Holds the offset, limit, total, and count info of the comics list
public struct ComicsData: Codable {
    
    // MARK: - Properties
    public let offset: Int
    public let limit: Int
    public let total: Int
    public let count: Int
    public let results: [Comic]
}
