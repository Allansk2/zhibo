//
//  BaseModel.swift
//  zhibo
//
//  Created by Regina on 2017-06-07.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    var tag_name: String = ""
    
    // icon url
    var icon_url: String = ""
    
    override init() {
        
    }
    
    init(dict : [String: NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
