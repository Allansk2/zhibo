//
//  CollectionCell.swift
//  zhibo
//
//  Created by Regina on 2017-05-31.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCell: CollectionViewBaseCell {
  
    @IBOutlet weak var locationBtn: UIButton!
    
    
    override var room: Room? {
        didSet {
            // pass it to parent class
            super.room = room

            // set location
            locationBtn.setTitle(room?.anchor_city, for: [])
            
        }
    }


}
