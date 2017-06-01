//
//  Date+Extension.swift
//  zhibo
//
//  Created by Regina on 2017-05-31.
//  Copyright © 2017 Allan. All rights reserved.
//

import Foundation


extension NSDate {
    class func getCurrentTime()->String {
        
        let interval = NSDate().timeIntervalSince1970
        return "\(interval)"
        
    }
}
