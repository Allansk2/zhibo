//
//  HeaderView.swift
//  zhibo
//
//  Created by Regina on 2017-05-31.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
   
    @IBOutlet weak var iconImageLeading: NSLayoutConstraint!
    
    var group: Anchor? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_live_cate_normal")
        }
    }
    
}

extension HeaderView {
    
    class func headerView ()-> HeaderView {
        return Bundle.main.loadNibNamed("HeaderView", owner: nil, options: nil)?.first as! HeaderView
    }
    
}
