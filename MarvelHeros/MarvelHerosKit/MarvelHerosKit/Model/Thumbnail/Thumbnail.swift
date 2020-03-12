import Foundation

public enum ThumbnailQuality: String {
    case landscapeIncredible = "/landscape_incredible"
    case fullSize = ""
}

/// The thumbnail of a marvel character
public struct Thumbnail: Codable {
    
    // MARK: - Properties
    let path: String
    let fileExtension: String
    
    // MARK: - Methods
    public func getUrl(quality: ThumbnailQuality) -> URL? {
        let httpsPath = "https" + path.dropFirst(4) + quality.rawValue
        return URL(string: "\(httpsPath).\(fileExtension)")
    }
}

extension Thumbnail {
    public enum CodingKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
}
