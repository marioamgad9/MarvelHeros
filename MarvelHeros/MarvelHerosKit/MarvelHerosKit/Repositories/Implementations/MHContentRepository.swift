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
    
    public func getImage(url: URL) -> Promise<UIImage> {
        return Promise<UIImage> { seal in
            AF.request(url, method: .get).response { response in
                switch response.result {
                case .success(let value):
                    guard let data = value,
                        let image = UIImage(data: data) else {
                            seal.reject(MarvelHerosKitError.unknown)
                            return
                    }
                    seal.fulfill(image)
                case .failure(let error):
                    print("API Error - An error occured, status code: \(response.response?.statusCode ?? 0)")
                    print("API Error - Alamofire error: \(error)")
                    if let data = response.data {
                        print("API Error - Returned JSON: \(String(describing: String(data: data, encoding: String.Encoding.utf8)))")
                    }
                    seal.reject(MarvelHerosKitError.unknown)
                }
            }
        }
    }
}
