//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/1/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import UIKit

class ActionsTableViewCell: UITableViewCell {

    @IBOutlet weak var btnComics: UIButton!
    @IBOutlet weak var btnSeries: UIButton!
    @IBOutlet weak var btnStories: UIButton!
    @IBOutlet weak var btnEvents: UIButton!
    
    var viewModel : ActionsTableViewModel?{
        didSet {
            observerViewModel()
        }
    }
    
    func observerViewModel() {
        btnComics.setTitle(viewModel?.character?.comics?.available?.description ?? "", for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func comics(_ sender: UIButton) {
        guard var comics = viewModel?.character?.comics else {return}
        guard let tableView = self.superview as? UITableView else {return}
        guard let viewController = tableView.superview?.parentViewController as? CharacterDetailViewController else {return}

        comics.type = MediaTypes.comics
        
        viewModel?.goMediaTypeVC(viewController: viewController, mediaTypeShort: comics)
    }

}
