//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/1/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Foundation
import ObjectMapper

struct Item: Mappable {
    
    var resourceURI: String?
    var name: String?
    var type: String?
    
    init?(map: Map) {}
    
    init() { }
    
    mutating func mapping(map: Map) {
        resourceURI <- map["resourceURI"]
        name <- map["name"]
        type <- map["type"]
    }
}
