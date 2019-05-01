//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import UIKit
import Foundation

protocol ActionsTableViewDataSource {
    var character : Character? { get }
}

protocol ActionsTableViewDelegate {
    func goMediaTypeVC(viewController: CharacterDetailViewController, mediaTypeShort: MediaTypeShort)
}
