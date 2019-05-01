//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Alamofire

class MediaTypeViewModel : MediaTypeViewDataSource {
    
    var service: MediaTypeService
    var dataSource: Dynamic<[MediaType]>
    var isLoadingDatasource: Dynamic<Bool>
    var isLoadingNext: Dynamic<Bool>
    
    init(url: String) {
        
        self.dataSource = Dynamic([])
        self.isLoadingDatasource = Dynamic(false)
        self.isLoadingNext = Dynamic(false)
        self.service = MediaTypeService(url: url)
        self.setDatasource()
    }
}

extension MediaTypeViewModel : MediaTypeViewDelegate {
    
    func setDatasource() {
        isLoadingDatasource.value = true
        service.get(handler)
    }
    
    func nextPage(){
        isLoadingNext.value = true
        service.getNext(handler)
    }
    
    func handler(result: Result<[MediaType]>){
        
        switch result {
        case .success(let value):
            self.dataSource.value += value
            
        case .failure(let error):
            print(error)
            
        }
        
        self.isLoadingNext.value = false
        self.isLoadingDatasource.value = false
    }
    
}
