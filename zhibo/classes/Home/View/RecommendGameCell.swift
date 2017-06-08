//
//  RecommendGameCell.swift
//  zhibo
//
//  Created by Regina on 2017-06-07.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit
import Kingfisher

class RecommendGameCell: UICollectionViewCell {

    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var base: BaseModel? {
        didSet {
            
            titleLabel.text = base?.tag_name
            // set icon image
            guard let url = URL(string: (base?.icon_url)!) else {
                return
            }
            iconImageView.kf.setImage(with: url)
        }
    }
 

}
