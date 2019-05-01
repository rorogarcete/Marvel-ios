//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/3/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Foundation
import ObjectMapper

struct MediaTypeShort: Mappable {
    
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items : [Item]?
    
    var type: MediaTypes?
    
    init?(map: Map) {
        
    }
    
    init(){}
    
    mutating func mapping(map: Map) {
        available <- map["available"]
        returned <- map["returned"]
        collectionURI <- map["collectionURI"]
        items <- map["items"]
    }
}
