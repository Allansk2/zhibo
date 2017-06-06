//
//  Anchor.swift
//  zhibo
//
//  Created by Regina on 2017-05-31.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class Anchor: NSObject {

    // room list
    var room_list: [[String: NSObject]]? {
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                rooms.append(Room(dict: dict))

            }
        }
    }
    
    var tag_name: String = ""
    
    // icon
    var icon_name: String = "home_header_normal"
    
    // Room models
    lazy var rooms: [Room] = [Room]()
    
    
    override init() {
         
    }
    
    init(dict : [String: NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
 
    
}
