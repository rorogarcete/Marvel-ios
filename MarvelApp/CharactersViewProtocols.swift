//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

protocol CharactersViewDataSource {
    var service : CharactersService { get }
    var title: String { get }
    var isLoadingDatasource: Dynamic<Bool> { get }
    var isLoadingNext: Dynamic<Bool> { get }
    var dataSource : Dynamic<[Character]> { get }
}

protocol CharactersViewDelegate {
    func setDatasource()
    func nextPage()
}
