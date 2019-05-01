//
//  Url.swift
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/5/19.
//  Copyright © 2019 Rodrigo Garcete. All rights reserved.
//

import Foundation

import Foundation
import ObjectMapper

struct Url: Mappable {
    
    var url: String?
    var type: String?
    
    init?(map: Map) {
        
    }
    
    init(){}
    
    mutating func mapping(map: Map) {
        url <- map["url"]
        type <- map["type"]
    }
}
