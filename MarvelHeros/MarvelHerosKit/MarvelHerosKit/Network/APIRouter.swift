import Alamofire

/// Creates the APIRequest for each endpoint
enum APIRouter: URLRequestConvertible {
    
    // MARK: - Endpoints
    case getMarvelCharacters(nameStartsWith: String?, offset: Int)
    case getMarvelCharacterDetails(id: Int)
    
    // MARK: - Methods
    func asURLRequest() throws -> URLRequest {
        // Construct url
        let url = try NetworkConstants.baseUrl.asURL()
        
        // Append path
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // Determine HTTP method
        urlRequest.httpMethod = method.rawValue
        
        // Set common headers
        urlRequest.setValue(NetworkConstants.ContentType.json, forHTTPHeaderField: NetworkConstants.HTTPHeaderField.acceptType)
        urlRequest.setValue(NetworkConstants.ContentType.json, forHTTPHeaderField: NetworkConstants.HTTPHeaderField.contentType)
        
        // Add query parameters to request
        if let parameters = parameters {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
    
    // MARK: - Properties
    private var method: HTTPMethod {
        switch self {
        case .getMarvelCharacters,
             .getMarvelCharacterDetails:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getMarvelCharacters:
            return "characters"
        case .getMarvelCharacterDetails(let id):
            return "characters/\(id)"
        }
    }
    
    private var parameters: Parameters? {
        let ts = String(Int(NSTimeIntervalSince1970))
        let stringToBeHashed = "\(ts)\(NetworkConstants.ParameterValues.privateAPIKey)\(NetworkConstants.ParameterValues.publicAPIKey)"
        let hash = stringToBeHashed.MD5()
        let commonParameters: Parameters = [NetworkConstants.ParameterKeys.apiKey: NetworkConstants.ParameterValues.publicAPIKey,
                                NetworkConstants.ParameterKeys.timeStamp: NSTimeIntervalSince1970,
                                NetworkConstants.ParameterKeys.hash: hash]
        switch self {
        case .getMarvelCharacters(let nameStartsWith, let offset):
            let parameters =  [NetworkConstants.ParameterKeys.offset: offset]
                .merging(commonParameters) { (current, _) in current }
            if let nameStartsWith = nameStartsWith {
                return parameters.merging([NetworkConstants.ParameterKeys.nameStartsWith: nameStartsWith]) { (current, _) in current }
            } else {
                return parameters
            }
        case .getMarvelCharacterDetails:
            return commonParameters
        }
    }
}
