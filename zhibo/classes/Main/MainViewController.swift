//
//  MainViewController.swift
//  zhibo
//
//  Created by Regina on 2017-05-29.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // setup UI
        setupUI()
        
        

     }
    
    
 
    
}



// MARK: - setup UI
extension MainViewController {
    
  
    // setup UI
    fileprivate func setupUI() {
        
        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Follow")
        addChildVC("Profile")

    }
    
    
    /// add child viewcontroller
    ///
    /// - Parameter name: child viewcontroller name
    fileprivate func addChildVC(_ name: String) {
        // 1. get controller from storyboard
        let childVC = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController() ?? UIViewController()
        
        // 2. add childviewcontroller
        addChildViewController(childVC)
    }
    
}
