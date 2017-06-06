//
//  CollectionSmallCell.swift
//  zhibo
//
//  Created by Regina on 2017-05-31.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class CollectionSmallCell: CollectionViewBaseCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var room: Room? {
        didSet {
            // pass it to parent class
            super.room = room
            
            // set room name
            roomNameLabel.text = room?.room_name

        }
    }
    
    
}
