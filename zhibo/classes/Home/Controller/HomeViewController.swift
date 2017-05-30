//
//  HomeViewController.swift
//  zhibo
//
//  Created by Regina on 2017-05-29.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
     }

}


// MARK: - setup UI
extension HomeViewController {
    
    fileprivate func setupUI() {
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
        // set left bar item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // set right bar item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highlightedImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlightedImageName: "btn_search_clicked", size: size)
        let qrItem = UIBarButtonItem(imageName: "Image_scan", highlightedImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrItem]
        
        
    }
    
}
