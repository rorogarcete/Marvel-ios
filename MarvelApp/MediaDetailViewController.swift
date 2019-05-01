//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/2/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import UIKit

class MediaDetailViewController: UIViewController {

    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var constraintHeader: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorCover: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelMessageResults: UILabel!
    
    fileprivate var maxHeaderSize : CGFloat!
    
    fileprivate var minHeaderSize : CGFloat = 35

    var viewModel: MediaDetailViewModel? {
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
                
                if viewModel == nil {
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
    
    enum Sections : Int {
        case Description = 0
        case Creators = 1
        case Urls = 2
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

        viewModel.setImage(imageView: imageCover, activityIndicator: activityIndicatorCover, url: viewModel.mediaType.value?.urlImage ?? "")
    }
    
    private func setTableView(){
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 600
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.contentInset = UIEdgeInsetsMake(-1.0, 0.0, 0.0, 0.0)
    }

}

extension MediaDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let mediaType = viewModel?.mediaType.value else {return UITableViewCell()}
        
        switch indexPath.section {
        case Sections.Description.rawValue:
            if indexPath.row == 0 {
                let cell = getDescriptionTableViewCell(description: mediaType.title ?? "Unavailable")
                cell.label.font = UIFont.boldSystemFont(ofSize: 17)
                return cell
            } else {
                if let description = mediaType.description, description != "" {
                    return getDescriptionTableViewCell(description: description)
                } else {
                    return getDescriptionTableViewCell(description: "Unavailable")
                }
            }
            
        case Sections.Creators.rawValue:
            guard let creator = mediaType.creators?.items?[indexPath.row] else {return UITableViewCell()}
            
            return getDescriptionTableViewCell(description: creator.name ?? "Unavailable")
            
            case Sections.Urls.rawValue:
                guard let url = mediaType.urls?[indexPath.row] else {return UITableViewCell()}
                return getDescriptionTableViewCell(description: url.type ?? "Unavailable")
            
            default:
                return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case Sections.Description.rawValue:
                return 2
            
            case Sections.Creators.rawValue:
                return viewModel?.mediaType.value?.creators?.items?.count ?? 0
            
            case Sections.Urls.rawValue:
                return viewModel?.mediaType.value?.urls?.count ?? 0
            
            default:
                return 0
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
        guard let _ = viewModel?.mediaType.value?.creators else {return 1}
        guard let _ = viewModel?.mediaType.value?.urls else {return 2}
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case Sections.Description.rawValue:
            return "Description"
            
        case Sections.Creators.rawValue:
            return "Creators"
            
        case Sections.Urls.rawValue:
            return "Urls"
            
        default:
            return nil
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case Sections.Description.rawValue:
            return
            
        case Sections.Creators.rawValue:
            return
            
        case Sections.Urls.rawValue:
            return
            
        default:
            return 
        }
    }
    
}

extension MediaDetailViewController {
    internal func getDescriptionTableViewCell(description: String)-> DescriptionTableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as! DescriptionTableViewCell
        
        cell.label.text = description
        
        return  cell
    }
 
}
