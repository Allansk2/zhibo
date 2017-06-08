//
//  GameViewModel.swift
//  zhibo
//
//  Created by Regina on 2017-06-07.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class GameViewModel {

    lazy var games: [GameModel] = [GameModel]()

    
}


// MARK: - request data
extension GameViewModel {
    
    func loadGameData(_ completion: @escaping ()->()) {
 
        NetworkManager.share.requestData(methodType: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"] as [String : AnyObject]) { (result, isSuccess) in
            
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
                let game = GameModel(dict: dict)
                self.games.append(game)
            }
            
            completion()
        }
  
    }
    
    
    
}
