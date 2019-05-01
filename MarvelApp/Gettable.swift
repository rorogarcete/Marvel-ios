//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/1/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

protocol Gettable {
    associatedtype Data
}

extension Gettable where Self.Data: Mappable {
    
    func get(fromURL url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding? = nil, headers: HTTPHeaders? = nil, keyPath : String? = nil, completionHandler: @escaping (Result<[Data]>) -> Void) {
        let request: DataRequest
        
        if let encoding = encoding {
            request = Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
        } else {
            request = Alamofire.request(url, method: method, parameters: parameters, headers: headers)
        }
        
        request.responseArray(keyPath: keyPath) { (response: DataResponse<[Data]>) in
            completionHandler(response.result)
        }

    }
    
}
