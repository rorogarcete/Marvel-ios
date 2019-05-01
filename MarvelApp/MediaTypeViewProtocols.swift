//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Foundation

protocol MediaTypeViewDataSource {
    var service : MediaTypeService { get }
    var isLoadingDatasource: Dynamic<Bool> { get }
    var isLoadingNext: Dynamic<Bool> { get }
    var dataSource : Dynamic<[MediaType]> { get }
}

protocol MediaTypeViewDelegate {
    func setDatasource()
    func nextPage()
}
