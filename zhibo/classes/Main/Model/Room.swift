//
//  Room.swift
//  zhibo
//
//  Created by Regina on 2017-05-31.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class Room: NSObject {

    // room id
    var room_id : Int = 0
    
    // url of room
    var vertical_src : String = ""
    
    // check live type
    // 0 : live computer 1 : live mobile
    var isVertical : Int = 0
    
    // room name
    var room_name: String = ""
    
    // nick name
    var nickname: String = ""
    
    // number of audience
    var online: Int = 0
    
    // city
    var anchor_city: String = ""
    
    init(dict: [String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}








