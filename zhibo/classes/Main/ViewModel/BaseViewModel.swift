//
//  BaseViewModel.swift
//  zhibo
//
//  Created by Regina on 2017-06-09.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class BaseViewModel: NSObject {

    lazy var anchorGroup: [Anchor] = [Anchor]()

    
}



extension BaseViewModel {
    
    
    func loadAnchorData(isGroup: Bool, urlStr: String, parameters: [String: AnyObject]? = nil, _ completion: @escaping ()->()) {
        
        NetworkManager.share.requestData(URLString: urlStr, parameters: parameters) { (result, isSuccess) in
            // kvc to dictionary
       
            guard let resultDict = result as? [String: NSObject] else {
                return
            }
            
            // get data
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else {
                return
            }
            
            if isGroup {
                //data to model
                for dict in dataArray {
                    let group = Anchor(dict: dict)
                    self.anchorGroup.append(group)
                    
                }
            }else {
                
                let group = Anchor()
                
                for dict in dataArray {
                    let room = Room(dict: dict)
                    group.rooms.append(room)
                    
                }
                self.anchorGroup.append(group)
  
            }
            
            
            completion()
        }
    }
    
}
