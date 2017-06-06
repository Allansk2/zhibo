//
//  RecommendViewController.swift
//  zhibo
//
//  Created by Regina on 2017-05-31.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

private let itemMargin: CGFloat = 10
private let itemW = (ScreenW - 3 * itemMargin) / 2
private let smallItemH = itemW * 0.75
private let itemH = itemW * 4 / 3

private let recycleViewH = ScreenW * 3 / 8

private let hearderViewH: CGFloat = 50

private let SmallItemCellId = "SmallItemCellId"
private let CellId = "CellId"
private let hearderViewId = "hearderViewId"

class RecommendViewController: UIViewController {

    fileprivate lazy var recommenVM: RecommendViewModel = RecommendViewModel()
    
    fileprivate lazy var collectionView: UICollectionView = { [unowned self] in
       
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
    
    fileprivate lazy var recycleView: RecycleView = {
        
        let recycleView = RecycleView.recycleView()
        recycleView.frame = CGRect(x: 0, y: -recycleViewH, width: ScreenW, height: recycleViewH)
        
        return recycleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup UI
        setupUI()
       
        // load data
        loadData()
        
    }
 

}



// MARK: - setup UI
extension RecommendViewController {
    
    fileprivate func setupUI() {
        
        // add collection view
        view.addSubview(collectionView)
        
        // add recycleview
        collectionView.addSubview(recycleView)
        
        // set collection insert
        collectionView.contentInset = UIEdgeInsets(top: recycleViewH, left: 0, bottom: 0, right: 0)
    
    }
    
}


// MARK: - load data
extension RecommendViewController {
    
    fileprivate func loadData(){
        
        recommenVM.loadData {
            
            // update UI
            self.collectionView.reloadData()
        }
    }
    
}



// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommenVM.anchorGroup.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommenVM.anchorGroup[section].rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get room data
        let group = recommenVM.anchorGroup[indexPath.section]
        let room = group.rooms[indexPath.item]

        
        //get cell
        var cell = CollectionViewBaseCell()
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId, for: indexPath) as! CollectionCell
        }else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallItemCellId, for: indexPath) as! CollectionSmallCell
            
        }
        cell.room = room
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // section header view
        
        // get group data
        let group = recommenVM.anchorGroup[indexPath.section]
        
        let hearderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: hearderViewId, for: indexPath) as! HeaderView

        hearderView.group = group
        
 
        return hearderView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: itemW, height: itemH)
        }
         return CGSize(width: itemW, height: smallItemH)
    }
}







