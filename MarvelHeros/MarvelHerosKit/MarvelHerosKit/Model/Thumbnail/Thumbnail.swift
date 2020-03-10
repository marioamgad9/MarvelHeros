import Foundation

/// The thumbnail of a marvel character
public struct Thumbnail: Codable {
    
    // MARK: - Properties
    let path: String
    let fileExtension: String
    
    // MARK: - Computed properties
    public var url: URL? {
        let httpsPath = "https" + path.dropFirst(4) + "/landscape_xlarge"
        return URL(string: "\(httpsPath).\(fileExtension)")
    }
}

extension Thumbnail {
    public enum CodingKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
}
