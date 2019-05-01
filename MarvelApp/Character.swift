//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/1/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Foundation
import ObjectMapper

class Character: Mappable {

    var id: Int?
    var name: String?
    var description: String?
    var resourceURI: String?
    var modified: String?
    
    var comics : MediaTypeShort?
    
    var thumbnail : Thumbnail?
    var urls : [Url]?
    
    var urlImage : String? {
        guard let thumb = thumbnail?.path else {return nil}
        guard let extensionPath = thumbnail?.extensionPath else {return nil}
        return thumb + "." + extensionPath
    }
        
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        resourceURI <- map["resourceURI"]
        modified <- map["modified"]
        thumbnail <- map["thumbnail"]
        comics <- map["comics"]
        urls <- map["urls"]
    }

}
