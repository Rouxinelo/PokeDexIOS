//
//  NetworkLayer.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 16/03/2022.
//

import Foundation
import Alamofire

typealias NetworkStartHandler = () -> ()
typealias NetworkErrorHandler = (Any?) -> ()
typealias NetworkFinishHandler = (Any?) -> ()

class NetworkLayer: NSObject {
    var start: NetworkStartHandler?
    var error: NetworkErrorHandler?
    var finish: NetworkFinishHandler?
    var api: API?
    var parameters: [String: Any]?
    var headers: [String: String]?
    
    func setStartHandler(start: @escaping NetworkStartHandler) {
        self.start = start
    }
    
    func setErrorHandler(error: @escaping NetworkErrorHandler) {
        self.error = error
    }
    
    func setFinishHandler(finish: @escaping NetworkFinishHandler) {
        self.finish = finish
    }
    
    private func getMethod(api: API) -> Alamofire.HTTPMethod {
        let requestMethod: Alamofire.HTTPMethod
        
        switch api.method {
        case "POST":
            requestMethod = Alamofire.HTTPMethod.post
            break
        case "PUT":
            requestMethod = Alamofire.HTTPMethod.put
            break
        case "DELETE":
            requestMethod = Alamofire.HTTPMethod.delete
            break
        default:
            requestMethod = Alamofire.HTTPMethod.get
            break
        }
        
        return requestMethod
        
    }
    
    // MARK: - Request URL
    
    func requestAPI(api: API, parameters: [String: AnyObject]?, headers: [String: String]?, completion: @escaping(ResultResponse<Data?>)-> ()) {
        self.api = api
        self.parameters = parameters
        self.headers = headers
        
        
        start?()
        AF.request(api.path,
                   method: getMethod(api: api),
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: HTTPHeaders(headers!)
        ).responseData(completionHandler: {
            (response) in
            switch response.result {
            case .success(let data):
                switch response.response!.statusCode {
                case 200:
                    self.finish?(response)
                    completion(ResultResponse.success(data))
                    break
                case 404:
                    self.error?(Error.self)
                    completion(ResultResponse.error(ErrorModel.notFound))
                default:
                    self.error?(Error.self)
                }
                break
            case .failure(let error):
                self.error?(error as NSError)
                break
            }
        }
        )
    }
    
}

