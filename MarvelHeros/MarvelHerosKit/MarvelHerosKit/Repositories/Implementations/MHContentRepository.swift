import Foundation
import PromiseKit
import Alamofire

/// The main content repository responsible for fetching remote data from API using Alamofire
public class MHContentRepository: ContentRepository {
    
    // MARK: - Methods
    public init() {}
    
    public func getMarvelCharacters(nameStartsWith: String?, offset: Int) -> Promise<MarvelCharactersAPIResponse> {
        return AF.requestWithPromise(APIRouter.getMarvelCharacters(nameStartsWith: nameStartsWith, offset: offset))
    }
    
    public func getMarvelCharacterDetails(id: Int) -> Promise<MarvelCharactersAPIResponse> {
        return AF.requestWithPromise(APIRouter.getMarvelCharacterDetails(id: id))
    }
}
