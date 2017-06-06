//
//  RecommendViewModel.swift
//  zhibo
//
//  Created by Regina on 2017-05-31.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class RecommendViewModel {
    
    
    lazy var anchorGroup: [Anchor] = [Anchor]()
    fileprivate lazy var hotGroup = Anchor()
    fileprivate lazy var prettyGroup = Anchor()
    
    
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
    
    func loadData(_ completion: @escaping ()->()) {
        
        let group = DispatchGroup()
        
        let parameter = ["limit": "4", "offset": "0", "time":NSDate.getCurrentTime()]
        
        group.enter()
        // 1. request recommend data, hot rooms
        NetworkManager.share.requestData(methodType: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()] as [String : AnyObject]) { (result, isSuccess) in
            
//            print(result)
            
            // kvc to dictionary
            guard let resultDict = result as? [String: NSObject] else {
                return
            }
            
            // get data
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else {
                return
            }
            
 
            self.hotGroup.tag_name = "热门"
            self.hotGroup.icon_name = "home_header_hot"
            
            //data to model
            for dict in dataArray {
                let room = Room(dict: dict)
                self.hotGroup.rooms.append(room)
                print(room.room_name)

            }
            print("---------")

            group.leave()
        }
        
        
        group.enter()
        // 2. request face data
        NetworkManager.share.requestData(methodType: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameter as [String : AnyObject]) { (result, isSuccess) in
            
//            print(result)
            
            // kvc to dictionary
            guard let resultDict = result as? [String: NSObject] else {
                return
            }
            
            // get data
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else {
                return
            }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            //data to model
            for dict in dataArray {
                let room = Room(dict: dict)
                self.prettyGroup.rooms.append(room)
                print(room.room_name)

            }
            print("---------")

            group.leave()
 
        }
        
        
        group.enter()
        // 3. request rest
        NetworkManager.share.requestData(methodType: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameter as [String : AnyObject]) { (result, isSuccess) in
            
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
            
            group.leave()
        }
        
        
        // when all data is ready,
        group.notify(queue: DispatchQueue.main) {
            
            self.anchorGroup.insert(self.prettyGroup, at: 0)
            self.anchorGroup.insert(self.hotGroup, at: 0)
            print("all data is ready")
             completion()
        }
        
    }
    
}
