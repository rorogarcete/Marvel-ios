//
//  CharacterCollectionViewModel.swift
//  Marvel-Swift-MVVM
//
//  Created by Felipe Silva  on 4/5/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import Foundation

struct CharacterCollectionViewModel: CharacterCollectionViewDataSource, SetImageViewDelegate {
    
    var title: String?
    var urlImage: String?
    var description: String?
    var modified: String?
    
    init(title: String, url: String) {
        self.title = title
        self.urlImage = url
    }
    
    init(title: String, url: String, description: String, modified: String) {
        self.title = title
        self.urlImage = url
        self.description = description
        self.modified = modified
    }
}

