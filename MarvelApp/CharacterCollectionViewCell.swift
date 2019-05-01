//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/1/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var modified: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
    var viewModel: CharacterCollectionViewModel? {
        didSet {
            observerViewModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func observerViewModel(){
        label.text = viewModel?.title
        modified.text = viewModel?.modified
        des.text = viewModel?.description
        
        viewModel?.setImage(imageView: imageView, activityIndicator: activityIndicator, url: viewModel?.urlImage ?? "")
    }

}
