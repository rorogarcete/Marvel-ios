//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/1/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import UIKit
import Alamofire

class CharactersViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelMessage: UILabel!
    
    @IBOutlet weak var activityIndicatorNext: UIActivityIndicatorView!
    
    private var isLoadingDataSource = false {
        didSet{
            if isLoadingDataSource {
                activityIndicator.startAnimating()
                labelMessage.isHidden = true
                
            } else {
                activityIndicator.stopAnimating()
                
                if viewModel?.dataSource.value == nil || viewModel?.dataSource.value.count == 0 {
                    
                    labelMessage.isHidden = false
                }
                
            }
            collectionView.reloadData()
        }
    }
    
    fileprivate var isLoadingNext = false {
        didSet {
            if isLoadingNext {
                activityIndicatorNext.startAnimating()
            } else {
                activityIndicatorNext.stopAnimating()
            }
        }
    }
    
    var viewModel : CharactersViewModel? {
        didSet {
            observerViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observerViewModel()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        let screenWidth = UIScreen.main.bounds.width
        
        layout.itemSize = CGSize(width: screenWidth / 2 - 10, height: screenWidth / 2 + screenWidth/5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCollectionViewCell")
    }


    fileprivate func observerViewModel(){
        
        if !isViewLoaded {
            return
        }
        
        guard let viewModel = viewModel else {
            return
        }
        
        title = viewModel.title
        
        viewModel.isLoadingDatasource.bind { [weak self] in
            self?.isLoadingDataSource = $0
        }
        
        viewModel.isLoadingNext.bind { [weak self] in
            self?.isLoadingNext = $0
        }
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailCharacter" {
            
            let vc = segue.destination as? CharacterDetailViewController
            
            if let char = sender as? Character {
                let viewModel = CharacterDetailViewModel(character: char)
                
                vc?.viewModel = viewModel
            }
        }
        
    }

}

extension CharactersViewController : UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let maximumOffset = scrollView.contentSize.height - self.collectionView.frame.size.height

        if viewModel?.dataSource.value.count == 0 {
            return
        }

        if  maximumOffset - scrollView.contentOffset.y <= 0  {
            if !isLoadingNext {
                viewModel?.nextPage()
            }
        }
    }
}

extension CharactersViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetailCharacter", sender: viewModel?.dataSource.value[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        
        return CGSize(width: screenWidth/2 - 10, height: screenWidth/2 + screenWidth/5);
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel?.dataSource.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let character = viewModel?.dataSource.value[indexPath.row] else {return UICollectionViewCell()}
        
        let cell = getCharacterCell(character: character, indexPath: indexPath)
        
        return cell
    }
    
}

extension CharactersViewController {
    
    func getCharacterCell(character : Character, indexPath: IndexPath) -> CharacterCollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        
        let viewModelCell = CharacterCollectionViewModel(title: character.name ?? "", url: character.urlImage ?? "", description: character.description ?? "", modified: character.modified ?? "")
        
        cell.viewModel = viewModelCell
        
        return cell
    }
    
}


