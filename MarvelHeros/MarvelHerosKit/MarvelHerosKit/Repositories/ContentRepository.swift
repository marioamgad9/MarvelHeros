import Foundation
import PromiseKit

/// The repository responsible for fetching remote data from API
public protocol ContentRepository {
    func getMarvelCharacters(nameStartsWith: String?, offset: Int) -> Promise<MarvelCharactersAPIResponse>
    func getImage(url: URL) -> Promise<UIImage>
}
