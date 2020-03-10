import Foundation

public enum MarvelHerosKitError: Error {
    
    // MARK: - General errors
    case noInternet
    case invalidAPIRequest
    case doesNotExist
    case unauthorized
    
    // MARK: - Unknown error
    case unknown
}
