//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Foundation

extension Int {
    
    static func random(min : Int, max : Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }

}
