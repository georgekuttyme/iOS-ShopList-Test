//
//  APIClientImplementation.swift
//  Shop-List
//
//  Created by Legends on 29/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import Alamofire
import Reachability

internal typealias NetworkCompletionHandler = (_ response: DataResponse<Data>) -> Void

internal class APIRequest {
    var baseURL: String?
    var path: String?
    var method: HTTPMethod = .get
    var parameters: Parameters?
    var encoding: ParameterEncoding { return JSONEncoding.default }
    private var headers: HTTPHeaders = ["Accept": "application/json"]

    func getHeaders() -> HTTPHeaders { return self.headers }
    convenience init(path: String, params: Parameters? = nil) {
           self.init()
           self.path = self.path ?? "" + path
           self.parameters = params
       }
}

class APIClientImplementation: APIClient {

    func execute(route: APIRequest,
                 completionHandler: @escaping NetworkCompletionHandler) {
        // Check the internet connection
        // If no internet connection, returns a customized no internet reposne to gateway
        let reachability = Reachability()
        if reachability?.connection == Reachability.Connection.none {
            completionHandler(self.configureNoInternetConnectionResponse())
            return
        }
        let url = URL(string: (apiBaseURL + (route.path ?? "")!))!
        print("Final URL : \(url)")
        print("All headers: \(route.getHeaders())")
        print("Params \(String(describing: route.parameters))")
        //TODO: Handle error data
        Alamofire.SessionManager.default.requestWithoutCache(url, method: route.method, parameters: route.parameters, encoding: route.encoding, headers: route.getHeaders())
        .validate()
        .responseData { (response) in
            print("Request URL \(response.request!.url!)")
            print("Status Code \(String(describing: response.response?.statusCode))")
            if let responseData = response.data {
                print("data \(responseData)")
                let strData = String(decoding: responseData, as: UTF8.self)
                print("Response data \(strData)")
            }
            completionHandler(response)
        }
    }

  
}

extension Alamofire.SessionManager {
    @discardableResult
    open func requestWithoutCache(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)// also you can add URLRequest.CachePolicy here as parameter
        -> DataRequest {
        do {
            var urlRequest = try URLRequest(url: url, method: method, headers: headers)
            urlRequest.cachePolicy = .reloadIgnoringCacheData // <<== Cache disabled
            let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
            return request(encodedURLRequest)
        } catch {
            // TODO: find a better way to handle error
            print(error)
            return request(URLRequest(url: URL(string: "http://example.com/wrong_request")!))
        }
    }
}

extension APIClientImplementation {
    func configureNoInternetConnectionResponse() -> DataResponse<Data> {
        let errorTemp = ["errorCode": "12163", "errorMessage": "Please check your internet connection"]
        let error = NSError(domain: "", code: 12163, userInfo: nil)
        let result = Result<Data>.failure(error)
        let response = DataResponse(request: nil, response: nil, data: self.jsonToNSData(json: errorTemp), result: result)
        return response
    }

    func jsonToNSData(json: Any) -> Data? {
           do {
               return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) as Data
           } catch let myJSONError {
               print(myJSONError)
           }
           return nil
       }
}
