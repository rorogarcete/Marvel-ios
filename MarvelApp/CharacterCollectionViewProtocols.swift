//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import UIKit

protocol CharacterCollectionViewDataSource {
    var title : String? { get }
    var urlImage: String? { get }
    var description: String? { get }
    var modified: String? { get }
}
