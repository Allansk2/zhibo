//
//  EntertainmentViewModel.swift
//  zhibo
//
//  Created by Regina on 2017-06-09.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class EntertainmentViewModel: BaseViewModel {
    
}


extension EntertainmentViewModel {
    
    func loadEntertainmentData(_ completion: @escaping ()->()) {
        loadAnchorData(isGroup:true, urlStr: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") {
            completion()
        }
 
    }

}
