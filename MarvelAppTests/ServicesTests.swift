//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import XCTest
@testable import MarvelApp

class ServicesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCharacterService() {
        let wait = expectation(description: "getChars")
        
        let service = CharactersService()
        XCTAssertNotNil(service)
        service.get { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.value?.first?.urlImage)
            wait.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)

    }
    
    func testMediaTypeService() {
        let wait = expectation(description: "getMedia")
        
        let service = MediaTypeService(url: "http://gateway.marvel.com/v1/public/characters/1011334/comics")
        
        XCTAssertNotNil(service)
        service.get { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.value?.first?.urlImage)
            wait.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
}
