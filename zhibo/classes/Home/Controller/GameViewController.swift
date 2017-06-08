//
//  GameViewController.swift
//  zhibo
//
//  Created by Regina on 2017-06-07.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

private let margin: CGFloat = 20
private let itemW: CGFloat = (ScreenW - 2 * margin) / 4
private let itemH: CGFloat = 85
private let headerViewH: CGFloat = 50
private let headerViewLeftMargin = margin + (itemW - 45) / 2

private let gameCellId = "gameCellId"
private let headerViewId = "headerViewId"

class GameViewController: UIViewController {
    
    lazy var gameVM: GameViewModel = GameViewModel()
 
    fileprivate lazy var collectionView: UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        layout.headerReferenceSize = CGSize(width: ScreenW, height: headerViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerViewId)
        collectionView.register(UINib(nibName: "RecommendGameCell", bundle: nil), forCellWithReuseIdentifier: gameCellId)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        
        collectionView.dataSource = self
        
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
 
        // setup UI
        setupUI()
        
        // load data
        loadData()
        
    }
 
 

}


extension GameViewController {
    
    fileprivate func setupUI() {
        view.addSubview(collectionView)

    }
}

// MARK: - load data
extension GameViewController {
    
    fileprivate func loadData(){
  
        gameVM.loadGameData {
            
            // update UI
            self.collectionView.reloadData()
  
        }
        
  
    }
    
}



// MARK: - UICollectionViewDataSource
extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewId, for: indexPath) as! HeaderView
 
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        headerView.iconImageLeading.constant = headerViewLeftMargin
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellId, for: indexPath) as!  RecommendGameCell

        cell.base = gameVM.games[indexPath.item]

        return cell
    }
    
}

