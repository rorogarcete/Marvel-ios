//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Foundation
import Alamofire

struct CharactersService: Gettable {
    
    var page: Int = 0
    typealias Data = Character
    fileprivate var filters: Parameters
    
    init() {
        filters = Credentials.getAuthorization()
    }
    
    func get(_ completionHandler: @escaping (Result<[Character]>) -> Void) {
        getPage(page: 0, completionHandler: completionHandler)
    }

}

extension CharactersService : Pageable {
    
    func getPage(page: Int, completionHandler: @escaping (Result<[Character]>) -> Void) {
        
        let url = API.Endpoints.characters
        
        var params = Parameters()
        
        params["offset"] = page
        
        params.merge(dictionary: self.filters)

        get(fromURL: url, parameters: params, encoding: URLEncoding.queryString, keyPath: "data.results", completionHandler: completionHandler)
    }

}
