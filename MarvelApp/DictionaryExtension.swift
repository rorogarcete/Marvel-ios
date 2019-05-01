//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/1/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Foundation

extension Dictionary {
    
    mutating func merge(dictionary: Dictionary<Key,Value>) {
        for (key, value) in dictionary {
            self[key] = value
        }
    }
    
}
