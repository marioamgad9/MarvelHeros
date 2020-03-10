import Foundation

/// Holds the API response of events list inside marvel character
public struct EventsAPIResponse: Codable {
    
    // MARK: - Properties
    public let available: Int
    public let items: [Event]
}
