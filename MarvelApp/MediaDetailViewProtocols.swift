//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import UIKit
import Foundation

protocol MediaDetailViewDataSource {
    
    var isLoadingImage: Dynamic<Bool> { get }
    var mediaType : Dynamic<MediaType?> { get }
}

