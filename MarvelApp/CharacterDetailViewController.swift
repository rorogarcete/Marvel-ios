//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import UIKit

enum Sections : Int {
    case CharacterDetail = 0
    case Urls = 1
}

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var constraintHeader: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorCover: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelMessageResults: UILabel!

    fileprivate var maxHeaderSize : CGFloat!
    
    fileprivate var minHeaderSize : CGFloat = 35
    
    var viewModel: CharacterDetailViewModel? {
        didSet {
            observerViewModel()
        }
    }

    private var isLoadingImage = false {
        didSet{
            if isLoadingImage {
                activityIndicator.startAnimating()
                labelMessageResults.isHidden = true
                tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            } else {
                activityIndicator.stopAnimating()
                
                if viewModel?.character.value == nil {
                    labelMessageResults.isHidden = false
                    tableView.separatorStyle = UITableViewCellSeparatorStyle.none
                    activityIndicatorCover.stopAnimating()
                } else {
                    tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
                }
            }
            tableView.reloadData()
        }
    }

    enum CellTypesCharacterDetail : Int {
        case Actions = 0
        case Description = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewController()
        setTableView()
        observerViewModel()
    }

    private func setViewController(){
        
        maxHeaderSize = view.bounds.height / 3
        constraintHeader.constant = view.bounds.height / 3
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
    }
    
    fileprivate func observerViewModel(){
        
        if !isViewLoaded {
            return
        }
        
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.isLoadingImage.bind { [weak self] in
            self?.isLoadingImage = $0
        }
        
        title = viewModel.title
        
        viewModel.setImage(imageView: imageCover, activityIndicator: activityIndicatorCover, url: viewModel.character.value?.urlImage ?? "")
        
    }

    private func setTableView(){
        
        tableView.register(UINib(nibName: "ActionsTableViewCell", bundle: nil), forCellReuseIdentifier: "ActionsTableViewCell")
        
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 600
        
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.contentInset = UIEdgeInsetsMake(-1.0, 0.0, 0.0, 0.0)
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "goToMediaType" {
            
            let vc = segue.destination as? MediaTypeViewController
            
            if let mediaShort = sender as? MediaTypeShort {
                let viewModel = MediaTypeViewModel(url: mediaShort.collectionURI ?? "")
                vc?.viewModel = viewModel
                vc?.title = mediaShort.type?.rawValue
            }
        }
    }
}

extension CharacterDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let char = viewModel?.character.value else {return UITableViewCell()}
        
        if indexPath.section == Sections.CharacterDetail.rawValue {
            
            switch indexPath.row {
                
            case CellTypesCharacterDetail.Actions.rawValue:
                return getActionsTableViewCell(char: char)
                
            case CellTypesCharacterDetail.Description.rawValue:
                
                if let descrition = viewModel?.character.value?.description, descrition != "" {
                    return getDescriptionTableViewCell(description: descrition)
                } else {
                    return getDescriptionTableViewCell(description: "No description available")
                }
                
            default:
                return UITableViewCell()
                
            }
            
        } else if indexPath.section == Sections.Urls.rawValue {
            
            guard let url = char.urls?[indexPath.row] else {return UITableViewCell()}
            
            let cell = getDescriptionTableViewCell(description: url.type ?? "")
            
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case Sections.CharacterDetail.rawValue:
                return 2
            default:
                return viewModel?.character.value?.urls?.count ?? 0
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPos = -scrollView.contentOffset.y
        
        let newSizeForHeader = constraintHeader.constant + yPos
        
        if newSizeForHeader > maxHeaderSize {
            constraintHeader.constant = maxHeaderSize
        } else if newSizeForHeader < minHeaderSize {
            constraintHeader.constant = minHeaderSize
        } else {
            constraintHeader.constant = newSizeForHeader
        }
        
        view.layoutIfNeeded()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == Sections.Urls.rawValue {
            
            if let urls = viewModel?.character.value?.urls, urls.count > 0 {
                return "URLs"
            }
            
        } else {
            return viewModel?.character.value?.name
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == Sections.Urls.rawValue {
            guard let url = viewModel?.character.value?.urls?[indexPath.row] else {return}
        }
        
    }
    
}

extension CharacterDetailViewController {
    internal func getActionsTableViewCell(char: Character)-> ActionsTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionsTableViewCell") as! ActionsTableViewCell
        
        let viewModel = ActionsTableViewModel(character: char)
        
        cell.viewModel = viewModel
        
        return  cell
    }
    
    internal func getDescriptionTableViewCell(description: String)-> DescriptionTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as! DescriptionTableViewCell
        
        cell.label.text = description
        
        return  cell
    }
 
    
}

