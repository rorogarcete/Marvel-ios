//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Foundation
import Alamofire

struct Credentials {
    
    static let publicKey = "42450c7c30ed07da81c79ddcb929343a"
    static let privateKey = "92b20d8b768c02a6be7c48ecb568aa60c623e7f7"
    
    static func getAuthorization() -> Parameters {
        
        let randonTimeStamp = Int.random(min: 100, max: 300)
        let hash = Encrypt.toMD5(string: randonTimeStamp.description + Credentials.privateKey + Credentials.publicKey)
        
        var params = Parameters()
        params["ts"] = randonTimeStamp.description
        params["apikey"] = Credentials.publicKey
        params["hash"] = hash
        params["limit"] = API.limit
        
        return params
    }
    
}
