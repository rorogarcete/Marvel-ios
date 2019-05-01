//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/1/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    
    @discardableResult
    public func responseInspector() -> Self {
        return responseJSON { response in
            debugPrint(response.request ?? "")
            debugPrint(response.response ?? "")
            debugPrint(response.data ?? "")
            debugPrint(response.result)
            print("")
        }
    }
    
}
