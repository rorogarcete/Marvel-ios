//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import XCTest
@testable import MarvelApp

class ViewControllersTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCharactersViewController() {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CharactersViewController") as! CharactersViewController

        vc.loadView()
        
        let viewModel = CharactersViewModel()
        viewModel.isLoadingDatasource.value = true
        viewModel.isLoadingNext.value = true
        viewModel.dataSource.value = [CharacterModel(), CharacterModel()]

        vc.viewModel = viewModel
        
        vc.viewDidLoad()
        
        viewModel.isLoadingDatasource.value = false
        viewModel.isLoadingNext.value = false

        vc.performSegue(withIdentifier: "goToDetailCharacter", sender: CharacterModel())

        XCTAssertNotNil(vc)
    }
    
    func testActionsTableViewCell(){
        
        let cell = Bundle.main.loadNibNamed("ActionsTableViewCell", owner: nil, options: nil)?[0] as! ActionsTableViewCell

        let viewModel = ActionsTableViewModel(character: CharacterModel())
        
        cell.viewModel = viewModel
        XCTAssertNotNil(cell)
    }
    
    func testDescriptionTableViewCell(){
        let cell = Bundle.main.loadNibNamed("DescriptionTableViewCell", owner: nil, options: nil)?[0] as! DescriptionTableViewCell
        XCTAssertNotNil(cell)
    }
    
    func testCharacterDetailViewController(){
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController

        vc.loadView()
        
        let char = CharacterModel()
        let urls : [Url] = [Url(), Url()]
        char.urls = urls
        
        let viewModel = CharacterDetailViewModel(character: char)
        
        viewModel.isLoadingImage.value = true
        vc.viewModel = viewModel
        
        vc.viewDidLoad()
        viewModel.isLoadingImage.value = false
        
        vc.tableView(vc.tableView, cellForRowAt: IndexPath(item: 0, section: 0))
        vc.tableView(vc.tableView, cellForRowAt: IndexPath(item: 1, section: 0))
        vc.tableView(vc.tableView, cellForRowAt: IndexPath(item: 0, section: 1))
        vc.tableView(vc.tableView, titleForHeaderInSection: 0)
        vc.tableView(vc.tableView, titleForHeaderInSection: 1)
        vc.tableView(vc.tableView, didSelectRowAt: IndexPath(item: 0, section: 1))
        
        vc.showWebView(url: Url())
        vc.performSegue(withIdentifier: "goToMediaType", sender: MediaTypeShort())
        
        XCTAssertNotNil(vc)
    }
    
    func testMediaTypeViewController(){
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MediaTypeViewController") as! MediaTypeViewController
        
        vc.loadView()
        
        let viewModel = MediaTypeViewModel(url: "http://gateway.marvel.com/v1/public/characters/1011334/comics")

        viewModel.isLoadingDatasource.value = true
        viewModel.isLoadingNext.value = true
        viewModel.dataSource.value = [MediaType(), MediaType()]
        
        vc.viewModel = viewModel
        vc.viewDidLoad()
        
        viewModel.isLoadingNext.value = false
        viewModel.isLoadingDatasource.value = false
        
        vc.scrollViewDidScroll(vc.collectionView)
        vc.collectionView(vc.collectionView, numberOfItemsInSection: vc.collectionView.numberOfSections)
        vc.collectionView(vc.collectionView, cellForItemAt: IndexPath(item: 0, section: 0))
        vc.collectionView(vc.collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        vc.performSegue(withIdentifier: "goToMediaDetail", sender: MediaType())
        XCTAssertNotNil(vc)
    }
    
    func testMediaDetailViewController(){
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MediaDetailViewController") as! MediaDetailViewController
        
        vc.loadView()
        
        let mediaType = MediaType()
        
        var creators = MediaTypeShort()
        creators.items = [Item(), Item()]
        
        let urls = [Url(), Url()]
        
        mediaType.creators = creators
        mediaType.urls = urls
        
        let viewModel = MediaDetailViewModel(mediaType: mediaType)

        viewModel.isLoadingImage.value = true
        vc.viewModel = viewModel
        
        vc.viewDidLoad()
        viewModel.isLoadingImage.value = false
        
        vc.tableView(vc.tableView, cellForRowAt: IndexPath(item: 0, section: 0))
        vc.tableView(vc.tableView, cellForRowAt: IndexPath(item: 1, section: 0))
        vc.tableView(vc.tableView, cellForRowAt: IndexPath(item: 0, section: 1))
        vc.tableView(vc.tableView, cellForRowAt: IndexPath(item: 0, section: 2))
        vc.tableView(vc.tableView, titleForHeaderInSection: 0)
        vc.tableView(vc.tableView, titleForHeaderInSection: 1)
        vc.tableView(vc.tableView, titleForHeaderInSection: 2)
        vc.tableView(vc.tableView, didSelectRowAt: IndexPath(item: 0, section: 2))
        
        vc.showWebView(url: Url())
        XCTAssertNotNil(vc)
    }
    
}
