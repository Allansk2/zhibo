
//
//  BaseAnchorViewController.swift
//  zhibo
//
//  Created by Regina on 2017-06-09.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

private let itemMargin: CGFloat = 10
let itemW = (ScreenW - 3 * itemMargin) / 2
let smallItemH = itemW * 0.75
let itemH = itemW * 4 / 3
private let hearderViewH: CGFloat = 50

private let SmallItemCellId = "SmallItemCellId"
let CellId = "CellId"
private let hearderViewId = "hearderViewId"

class BaseAnchorViewController: BaseViewController {

    var baseVM: BaseViewModel!
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        
        // create flow layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemW, height: smallItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = itemMargin
        layout.headerReferenceSize = CGSize(width: ScreenW, height: hearderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)
        
        // create collection view
        var collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionSmallCell", bundle: nil), forCellWithReuseIdentifier: SmallItemCellId)
        collectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: CellId)
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: hearderViewId)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        return collectionView
        
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupUI()
        
        loadData()
        
    }

 

}

// MARK: - set up UI
extension BaseAnchorViewController {
    
    override func setupUI() {
        
        contentView = collectionView
        
        view.addSubview(collectionView)

        super.setupUI()
        
        
    }
}


// MARK: - load data
extension BaseAnchorViewController {
    
    func loadData() {

    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension BaseAnchorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
 
        return baseVM.anchorGroup.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        return baseVM.anchorGroup[section].rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallItemCellId, for: indexPath) as! CollectionSmallCell
 
        
        // get room data
        let group = baseVM.anchorGroup[indexPath.section]
        let room = group.rooms[indexPath.item]
        
        cell.room = room
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // section header view
        
   
        let hearderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: hearderViewId, for: indexPath) as! HeaderView
      
        // get group data
        let group = baseVM.anchorGroup[indexPath.section]
        hearderView.group = group
         
        return hearderView
    }
    
 
}




