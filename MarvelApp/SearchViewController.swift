//
//  SearchViewController.swift
//  Marvel-Swift-MVVM
//
//  Created by Felipe Silva  on 4/6/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelMessage: UILabel!
    
    @IBOutlet weak var activityIndicatorNext: UIActivityIndicatorView!
    
    /// Controls UI components for user feedback
    private var isLoadingDataSource = false {
        didSet{
            if isLoadingDataSource {
                activityIndicator.startAnimating()
                labelMessage.isHidden = true
                
            } else {
                activityIndicator.stopAnimating()
                
                if viewModel?.dataSource.value == nil || viewModel?.dataSource.value.count == 0 {
                    labelMessage.isHidden = false
                    
                } else {
                    labelMessage.isHidden = true
                }
                
            }
            collectionView.reloadData()
        }
    }
    
    var textSearch : String?
    
    fileprivate var isLoadingNext = false {
        didSet {
            if isLoadingNext {
                activityIndicatorNext.startAnimating()
            } else {
                activityIndicatorNext.stopAnimating()
            }
        }
    }
    
    var viewModel: CharactersViewModel? {
        didSet {
            observerViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search Characters"
        searchBar.text = textSearch
        configureCollectionView()
        observerViewModel()
    }
    
    private func configureCollectionView(){
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
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
            
            if let char = sender as? CharacterModel {
                let viewModel = CharacterDetailViewModel(character: char)
                
                vc?.viewModel = viewModel
            }
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        viewModel?.setDatasource(name: searchBar.text, cleanDataSource: true)
    }
    
}

extension SearchViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        searchBar.endEditing(true)
        
        let maximumOffset = scrollView.contentSize.height - self.collectionView.frame.size.height
        
        
        if  maximumOffset - scrollView.contentOffset.y <= 0  {
            if !isLoadingNext {
                viewModel?.nextPage()
            }
        }
        
    }
    
}

extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToDetailCharacter", sender: viewModel?.dataSource.value[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        
        return CGSize(width: screenWidth/2 - 10, height: screenWidth/2 + screenWidth/5)
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

extension SearchViewController {
    
    func getCharacterCell(character : CharacterModel, indexPath: IndexPath) -> CharacterCollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        
        let viewModelCell = CharacterCollectionViewModel(title: character.name ?? "", url: character.urlImage ?? "")
        
        cell.viewModel = viewModelCell
        
        return cell
    }

}

