//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Foundation

struct CharacterDetailViewModel : CharacterDetailViewDataSource, SetImageViewDelegate {
    
    var title = "Detail Character"
    var character: Dynamic<Character?>
    var isLoadingImage: Dynamic<Bool>

    init(character: Character) {
        self.character = Dynamic(character)
        self.isLoadingImage = Dynamic(false)
    }
    
}
