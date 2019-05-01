//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Foundation
import Alamofire

struct MediaTypeService: Gettable {
    
    var page: Int = 0
    typealias Data = MediaType
    fileprivate var filters: Parameters
    var url: String!
    
    init(url: String) {
        self.url = url
        filters = Credentials.getAuthorization()
    }
    
    func get(_ completionHandler: @escaping (Result<[MediaType]>) -> Void) {
        getPage(page: 0, completionHandler: completionHandler)
    }
    
}

extension MediaTypeService : Pageable {
    
    func getPage(page: Int, completionHandler: @escaping (Result<[MediaType]>) -> Void) {
        
        var params = Parameters()
        
        params["offset"] = page
        
        params.merge(dictionary: self.filters)
        
        get(fromURL: self.url, parameters: params, encoding: URLEncoding.queryString, keyPath: "data.results", completionHandler: completionHandler)
    }
    
}
