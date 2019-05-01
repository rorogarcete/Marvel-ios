//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Foundation
import Alamofire

protocol Pageable: Gettable {
    var page: Int {get set}
    mutating func getNext(_ completionHandler: @escaping (Result<[Self.Data]>) -> Void)
    func getPage(page: Int, completionHandler: @escaping (Result<[Self.Data]>) -> Void)
}

extension Pageable {
    mutating func getNext(_ completionHandler: @escaping (Result<[Self.Data]>) -> Void) {
        page += API.limit
        getPage(page: page, completionHandler: completionHandler)
    }
}
