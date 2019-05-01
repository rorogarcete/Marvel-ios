//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import XCTest
@testable import MarvelApp

class ViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testActionsViewModel() {
        let viewModel = ActionsTableViewModel(character: CharacterModel())
        XCTAssertNotNil(viewModel)
    }
    
    func testCharacterDetailViewModel(){
        let char = CharacterModel()
        var thumbnail = Thumbnail()
        
        thumbnail.extensionPath = "http://i.annihil.us/u/prod/marvel/i/mg/d/03/58dd080719806"
        thumbnail.path = "jpg"
        
        char.thumbnail = thumbnail
        
        let viewModel = CharacterDetailViewModel(character: char)
        viewModel.setImage(imageView: UIImageView(), activityIndicator: UIActivityIndicatorView(), url: "")
        XCTAssertNotNil(viewModel)
    }
    
    func testNotImageCharacterDetailViewModel(){
        let char = CharacterModel()
        let viewModel = CharacterDetailViewModel(character: char)
        
        viewModel.setImage(imageView: UIImageView(), activityIndicator: UIActivityIndicatorView(), url: "")
        XCTAssertNotNil(viewModel)
    }
    
    func testCharacterCollectionViewModel(){
        let viewModel = CharacterCollectionViewModel(title: "", url: "http://i.annihil.us/u/prod/marvel/i/mg/d/03/58dd080719806.jpg")
        
        viewModel.setImage(imageView: UIImageView(), activityIndicator: UIActivityIndicatorView(), url: "")
        XCTAssertNotNil(viewModel)
    }

    func testNotImageCharacterCollectionViewModel(){
        let viewModel = CharacterCollectionViewModel(title: "", url: "")
        
        viewModel.setImage(imageView: UIImageView(), activityIndicator: UIActivityIndicatorView(), url: "")
        XCTAssertNotNil(viewModel)
    }
    
    func testCharactersViewModel(){
        let viewModel = CharactersViewModel(name: "Iron")
        viewModel.setDatasource(name: "Spider", cleanDataSource: true)
        viewModel.nextPage()
        XCTAssertNotNil(viewModel)
    }

    func testMediaTypeViewModel(){
        let viewModel = MediaTypeViewModel(url: "http://gateway.marvel.com/v1/public/characters/1011334/comics")
        viewModel.setDatasource()
        viewModel.nextPage()
        XCTAssertNotNil(viewModel)
    }
    
    func testMediaDetailViewModel(){
        
        let mediaType = MediaType()
        
        var thumbnail = Thumbnail()
        
        thumbnail.extensionPath = "http://i.annihil.us/u/prod/marvel/i/mg/d/03/58dd080719806"
        thumbnail.path = "jpg"
        
        mediaType.thumbnail = thumbnail

        let viewModel = MediaDetailViewModel(mediaType: mediaType)
        viewModel.setImage(imageView: UIImageView(), activityIndicator: UIActivityIndicatorView(), url: "")
        XCTAssertNotNil(viewModel)
    }
    
    func testNotImageMediaDetailViewModel(){
        
        let mediaType = MediaType()
        
        let viewModel = MediaDetailViewModel(mediaType: mediaType)
        viewModel.setImage(imageView: UIImageView(), activityIndicator: UIActivityIndicatorView(), url: "")
        XCTAssertNotNil(viewModel)
    }
    
}
