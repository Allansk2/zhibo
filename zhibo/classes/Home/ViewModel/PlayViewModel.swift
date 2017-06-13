//
//  PlayViewModel.swift
//  zhibo
//
//  Created by Regina on 2017-06-10.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class PlayViewModel: BaseViewModel {

}


extension PlayViewModel {
    
    func loadPlayData(_ completion: @escaping ()->()) {
    
        loadAnchorData(isGroup:false, urlStr: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0] as [String : AnyObject] ) {
            
            completion()
        }
        
    }
}
