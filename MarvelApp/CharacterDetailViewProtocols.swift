//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import UIKit
import Foundation

protocol CharacterDetailViewDataSource {
    var title: String { get }
    var isLoadingImage: Dynamic<Bool> { get }
    var character : Dynamic<Character?> { get }
}

