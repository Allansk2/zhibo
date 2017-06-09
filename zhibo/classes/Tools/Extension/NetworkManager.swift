//
//  NetworkManager.swift
//  zhibo
//
//  Created by Regina on 2017-05-31.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit
import Alamofire

enum HTTPMETHOD {
    case GET
    case POST
}

class NetworkManager: NSObject {

    static let share: NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()
    
    func requestData(methodType: HTTPMETHOD = .GET, URLString: String, parameters: [String: AnyObject]?, completion: @escaping (_ json: Any?, _ success: Bool)->()) {
     
        // get parameters
        var parameters = parameters
        if parameters == nil {
            parameters = [String: AnyObject]()
        }
        
        let method = methodType == .GET ? HTTPMethod.get : HTTPMethod.post
 
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            guard let result = response.result.value else {
                completion(nil, false)
                return
            }
    
            completion(result, true)
        }
        
    }
    
}
