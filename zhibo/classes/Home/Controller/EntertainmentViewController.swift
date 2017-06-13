//
//  EntertainmentViewController.swift
//  zhibo
//
//  Created by Regina on 2017-06-09.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

private let menuViewH: CGFloat = 200

class EntertainmentViewController: BaseAnchorViewController {

    fileprivate lazy var entertainmentVM: EntertainmentViewModel = EntertainmentViewModel()
    
    fileprivate lazy var menuView: MenuView = {
        let menuView = MenuView.menuView()
        menuView.frame = CGRect(x: 0, y: -menuViewH, width: ScreenW, height: menuViewH)
 
        return menuView
        
    }()
    
    
    
}


extension EntertainmentViewController {
 
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(menuView)
        
        collectionView.contentInset = UIEdgeInsets(top: menuViewH, left: 0, bottom: 0, right: 0)
    }
    
}


// MARK: - load data
extension EntertainmentViewController {
    
    override func loadData() {
        
        baseVM = entertainmentVM
        
        entertainmentVM.loadEntertainmentData {
            
            self.collectionView.reloadData()
            
            self.menuView.anchorGroup = self.entertainmentVM.anchorGroup
            
            self.dataLoaded()
        }
    }
    
}

