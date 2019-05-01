//
//  Extension.swift
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/5/19.
//  Copyright © 2019 Felipe Silva . All rights reserved.
//

import Foundation

extension Dictionary {
    
    mutating func merge(dictionary: Dictionary<Key,Value>) {
        for (key, value) in dictionary {
            self[key] = value
        }
    }
    
}
