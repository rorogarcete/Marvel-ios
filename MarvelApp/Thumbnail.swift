//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Foundation
import ObjectMapper

struct Thumbnail: Mappable {
    
    var path: String?
    var extensionPath: String?
    
    init?(map: Map) {}
    
    init(){}
    
    mutating func mapping(map: Map) {
        path <- map["path"]
        extensionPath <- map["extension"]
    }
}
