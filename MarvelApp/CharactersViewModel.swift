//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Alamofire

class CharactersViewModel : CharactersViewDataSource {
    
    var title = "Characters Marvel"
    var dataSource: Dynamic<[Character]>
    var isLoadingDatasource: Dynamic<Bool>
    var isLoadingNext: Dynamic<Bool>
    var service = CharactersService()
    
    init(name: String? = nil) {
        self.dataSource = Dynamic([])
        self.isLoadingDatasource = Dynamic(false)
        self.isLoadingNext = Dynamic(false)

        if let name = name {
            self.setDatasource(name: name)
        } else {
            self.setDatasource()
        }
    }
    
}

extension CharactersViewModel : CharactersViewDelegate {
    @objc func setDatasource() {
        isLoadingDatasource.value = true
        service.get(handler)
    }
    
    func setDatasource(name: String? = nil, cleanDataSource: Bool? = false){
        
        isLoadingDatasource.value = true
        
        if name != nil {
            if cleanDataSource! {
                self.dataSource = Dynamic([])
            }
            service.get(handler)
        }

    }
    
    func nextPage(){
        
        isLoadingNext.value = true
        service.getNext(handler)
    }
    
    func handler(result: Result<[Character]>){
        
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
