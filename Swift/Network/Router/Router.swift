
Alamofire.request(Router.CreateCustomer).responseJSON { response in
            guard let id = response.result.value?.valueForKey("id") as? String else {
                completion(id: nil, success: false)
                return
            }
            completion(id: id, success: true)
        }

import Alamofire

enum Router: URLRequestConvertible {
    static let baseURL = NSURL(string: "http://ServerAddress.com")!

    case Status
    case Token
    case CreateCustomer
    case CreatePaymentMethod

    var URL: NSURL {
        return Router.baseURL.URLByAppendingPathComponent(route.path)
    }

    var method: Alamofire.Method {
        switch self {
        case .Status:
            return .GET
        case .Token:
            return .GET
        case .CreateCustomer:
            return .POST
        case CreatePaymentMethod:
            return .POST
        }
    }

    var route: (path: String, parameters: [String : AnyObject]?) {
        switch self {
        case .Status:
            return ("/", nil)

        case .Token:
            return ("/token", nil)

        case .CreateCustomer:
            return ("/createCustomer", nil)

        case CreatePaymentMethod:
            return("CreatePaymentMethod", nil)
        }
    }

    var URLRequest: NSMutableURLRequest {
        let request = Alamofire.ParameterEncoding.URL.encode(NSURLRequest(URL: URL), parameters: (route.parameters ?? [:])).0
        request.HTTPMethod = method.rawValue
        return request
    }
}
