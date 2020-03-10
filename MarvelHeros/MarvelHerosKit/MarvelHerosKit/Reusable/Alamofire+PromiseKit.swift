import Alamofire
import PromiseKit

extension AF {
    /// Triggers an HTTPRequest using alamofire with a promise as a return type
    public static func requestWithPromise<T: Codable>(_ urlConvertible: Alamofire.URLRequestConvertible) -> Promise<T> {
        return Promise<T> { seal in
            // Trigger the HTTPRequest using Alamofire
            AF.request(urlConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
                // Check result from response and map it the the promise
                switch response.result {
                case .success(let value):
                    seal.fulfill(value)
                case .failure(let error):
                    print("API Error - An error occured, status code: \(response.response?.statusCode ?? 0)")
                    print("API Error - Alamofire error: \(error)")
                    if let data = response.data {
                        print("API Error - Returned JSON: \(String(describing: String(data: data, encoding: String.Encoding.utf8)))")
                    }
                    
                    switch response.response?.statusCode {
                    case 401:
                        seal.reject(MarvelHerosKitError.unauthorized)
                    case 404:
                        seal.reject(MarvelHerosKitError.doesNotExist)
                    case 409:
                        seal.reject(MarvelHerosKitError.invalidAPIRequest)
                    default:
                        guard NetworkReachabilityManager()?.isReachable ?? false else {
                            seal.reject(MarvelHerosKitError.noInternet)
                            return
                        }
                        seal.reject(MarvelHerosKitError.unknown)
                    }
                }
            }
        }
    }
}
