//
//  HomeViewController.swift
//  zhibo
//
//  Created by Regina on 2017-05-29.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

let titleViewH: CGFloat = 40

class HomeViewController: UIViewController {
    
    fileprivate lazy var titleView: TitleView = {
        
        let rect = CGRect(x: 0, y: StatusBarH + NavigationBarH, width: ScreenW, height: titleViewH )
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = TitleView(frame: rect, titles: titles)
        return titleView
    }()
    
    fileprivate lazy var contentView: ContentView = {
        let contentY = StatusBarH + NavigationBarH + titleViewH
        let rect = CGRect(x: 0, y: contentY, width: ScreenW, height: ScreenH -  contentY)
        
        var childVCs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            childVCs.append(vc)
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
        }
        let contentView = ContentView(frame: rect, childVCs: childVCs, parentVC: self)
        return contentView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        // setup UI
        setupUI()
     }

}


// MARK: - setup UI
extension HomeViewController {
    
    fileprivate func setupUI() {
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        view.addSubview(titleView)
        
        view.addSubview(contentView)
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
