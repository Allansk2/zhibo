//
//  RecommendViewModel.swift
//  zhibo
//
//  Created by Regina on 2017-05-31.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class RecommendViewModel {
    
    
    fileprivate lazy var anchorGroup: [Anchor] = [Anchor]()
    
    
//    func loadData() {
//        
//        NetworkManager.share.requestData(methodType: .GET, URLString: "http://httpbin.org/get", parameters: ["name": "why" as AnyObject]) { (result, isSuccess) in
//            
//            print(result)
//        }
//    }

}



// MARK: - request data
extension RecommendViewModel {
    
    func loadData(_ completion: ()->()) {
        
        let parameter = ["limit": "4", "offset": "0", "time":NSDate.getCurrentTime()]
        
        // 1. request recommend data
        
        
        
        // 2. request face data
        
        
        
        
        // 3. request rest
        
        NetworkManager.share.requestData(methodType: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameter as [String : AnyObject]) { (result, isSuccess) in
            
            print(result)
            
            // kvc to dictionary
            guard let resultDict = result as? [String: NSObject] else {
                return
            }
            
            // get data
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else {
                return
            }
            
            //data to model
            for dict in dataArray {
                let group = Anchor(dict: dict)
                self.anchorGroup.append(group)
                
            }
            
            var anchorGroupnew: [Anchor] = self.anchorGroup
            
          
            for group in self.anchorGroup {
                
                for room in group.rooms {
                    print(room.room_name)
                }
                print("---------")
            }
        }
    }
    
}
