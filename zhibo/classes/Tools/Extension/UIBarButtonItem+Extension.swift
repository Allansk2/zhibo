//
//  UIBarButtonItem+Extension.swift
//  zhibo
//
//  Created by Regina on 2017-05-29.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
  
    
    /// create custom uibarbutton item
    ///
    /// - Parameters:
    ///   - ImageName: image name
    ///   - highlighted: highlighted image name
    ///   - size: size 
    convenience init(imageName: String, highlightedImageName: String = "", size: CGSize = CGSize.zero) {
        
        // create UIButton
        let btn = UIButton()
        
        // set normal image
        btn.setImage(UIImage(named:imageName), for: .normal)
        
        // set highlighted image
        if (highlightedImageName != "") {
            btn.setImage(UIImage(named:highlightedImageName), for: .highlighted)
        }
        
        // set size
        if (size != CGSize.zero) {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }else {
            btn.sizeToFit()
        }
        
        
        self.init(customView: btn)
    }
    
    
}
