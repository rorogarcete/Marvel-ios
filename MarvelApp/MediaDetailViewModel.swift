//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Foundation

struct MediaDetailViewModel : MediaDetailViewDataSource, SetImageViewDelegate {
    
    var mediaType: Dynamic<MediaType?>
    var isLoadingImage: Dynamic<Bool>
    
    init(mediaType: MediaType) {
        self.mediaType = Dynamic(mediaType)
        self.isLoadingImage = Dynamic(false)
    }
    
}

