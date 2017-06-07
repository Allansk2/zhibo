//
//  RecycleCell.swift
//  zhibo
//
//  Created by Regina on 2017-06-06.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit
import Kingfisher

class RecycleCell: UICollectionViewCell {
 
    @IBOutlet weak var previewImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
 
    var recycleModel: RecycleModel? {
        didSet {
            titleLabel.text = recycleModel?.title
            // set preview image
            guard let url = URL(string: (recycleModel?.pic_url)!) else {
                return
            }
            previewImageView.kf.setImage(with: url)
            
        }
    }

}
