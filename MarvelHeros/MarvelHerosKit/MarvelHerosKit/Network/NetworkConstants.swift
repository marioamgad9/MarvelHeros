import Foundation

/// Holds the constants related to networking
struct NetworkConstants {
    
    /// Api version
    static let apiVersion = "v1"
    
    /// The base url of the API
    static let baseUrl = "https://gateway.marvel.com:443/\(apiVersion)/public/"
    
    /// Parameter keys
    struct ParameterKeys {
        // Common parameters
        static let apiKey = "apikey"
        static let hash = "hash"
        static let timeStamp = "ts"
        
        // Characters parameters
        static let nameStartsWith = "nameStartsWith"
        static let offset = "offset"
    }
    
    /// Parameter values
    struct ParameterValues {
        static let publicAPIKey = APIKeysProvider.publicAPIKey
        static let privateAPIKey = APIKeysProvider.privateAPIKey
    }
    
    /// HTTP header fields
    struct HTTPHeaderField {
        static let contentType = "Content-Type"
        static let acceptType = "Accept"
        static let acceptEncoding = "Accept-Encoding"
    }
    
    /// Content type
    struct ContentType {
        static let json = "application/json"
    }
}
