//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/3/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol SetImageViewDelegate {
    func setImage(imageView: UIImageView, activityIndicator: UIActivityIndicatorView, url: String)
}

extension SetImageViewDelegate {

    func setImage(imageView: UIImageView, activityIndicator: UIActivityIndicatorView, url: String) {
        guard let url = URL(string: url) else {
            imageView.image = UIImage(named: "placeholder")
            activityIndicator.stopAnimating()
            return
        }
        
        let resource = ImageResource(downloadURL: url)
        
        imageView.kf.setImage(with: resource, placeholder: Image(named: "placeholder"), options: nil, progressBlock: nil) { image, error, cache, url in
            activityIndicator.stopAnimating()
        }
    }

}
