//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/3/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Foundation

enum MediaTypes: String {
    case comics
    case series
    case events
    case stories
}

struct API {
    
    static let limit = 20
    
    static let host = "https://gateway.marvel.com"
    static let baseURL = host + "/v1/public/"
    
    struct Endpoints {
        static let characters = baseURL + "characters"
    }
    
}
