//
//  PlayViewController.swift
//  zhibo
//
//  Created by Regina on 2017-06-10.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

private let topMargin: CGFloat = 10

class PlayViewController: BaseAnchorViewController {
    
    fileprivate lazy var playViewModel: PlayViewModel = PlayViewModel()
  
}

extension PlayViewController {
    
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        
        collectionView.contentInset = UIEdgeInsets(top: topMargin, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - load data
extension PlayViewController {
    
    override func loadData() {
        
        baseVM = playViewModel
        
        playViewModel.loadPlayData {
            
            self.collectionView.reloadData()
            
            self.dataLoaded()

        }
    }
    
}
