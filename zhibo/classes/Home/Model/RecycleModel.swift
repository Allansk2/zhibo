//
//  RecycleModel.swift
//  zhibo
//
//  Created by Regina on 2017-06-06.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class RecycleModel: NSObject {
    // title
    var title : String = ""
    // picture url
    var pic_url : String = ""
    // room infor
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else  { return }
            roomObject = Room(dict: room)
        }
    }
    // room object
    var roomObject : Room?
    
    
    // MARK:-  
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
