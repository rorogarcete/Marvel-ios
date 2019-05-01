//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/1/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import ObjectMapper
import Foundation

class MediaType: Mappable {
    
    var id: Int?
    var title: String?
    var description: String?
    var resourceURI: String?
    var thumbnail: Thumbnail?

    var urlImage : String? {
        guard let thumb = thumbnail?.path else {return nil}
        guard let extensionPath = thumbnail?.extensionPath else {return nil}
        return thumb + "." + extensionPath
    }
    
    var creators: MediaTypeShort?
    var characters: MediaTypeShort?

    var urls: [Url]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        resourceURI <- map["resourceURI"]
        thumbnail <- map["thumbnail"]
        creators <- map["creators"]
        characters <- map["characters"]
        urls <- map["urls"]
    }

}

