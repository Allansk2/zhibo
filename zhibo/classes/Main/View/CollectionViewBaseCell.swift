//
//  CollectionViewBaseCell.swift
//  zhibo
//
//  Created by Regina on 2017-06-05.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class CollectionViewBaseCell: UICollectionViewCell {
 
    // MARK
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    var room: Room? {
        didSet {
            // check if model object valid
            guard let room = room else {
                return
            }
            
            // set online number
            var onlineStr: String = "\(room.online)"
            // get online number
            if room.online >= 10000 {
                let number = Float(room.online) / 10000
                onlineStr = "\(String(format: "%.1f", number))万"
            }
            onlineBtn.setTitle(onlineStr, for: [])
            
            // set nick name
            nicknameLabel.text = room.nickname
            
            // set preview image
            guard let url = URL(string: room.vertical_src) else {
                return
            }
            previewImageView.kf.setImage(with: url)
            
        }
    }
    
}
