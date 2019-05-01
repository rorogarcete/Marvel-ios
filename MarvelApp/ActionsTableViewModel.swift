//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import UIKit
import Foundation

struct ActionsTableViewModel : ActionsTableViewDataSource {
    
    var character: Character?
    
    init(character: Character) {
        self.character = character
    }
    
}

extension ActionsTableViewModel : ActionsTableViewDelegate {
    func goMediaTypeVC(viewController: CharacterDetailViewController, mediaTypeShort: MediaTypeShort) {
        viewController.performSegue(withIdentifier: "goToMediaType", sender: mediaTypeShort)
    }
}
