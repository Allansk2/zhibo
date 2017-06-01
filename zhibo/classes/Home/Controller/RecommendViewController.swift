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
private let itemH = itemW * 0.75
private let hearderViewH: CGFloat = 50

private let smallItemCellId = "smallItemCellId"
private let hearderViewId = "hearderViewId"

class RecommendViewController: UIViewController {

    fileprivate lazy var collectionView: UICollectionView = { [unowned self] in
       
        // create flow layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = itemMargin
        layout.headerReferenceSize = CGSize(width: ScreenW, height: hearderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)
        
        // create collection view
        var collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionSmallCell", bundle: nil), forCellWithReuseIdentifier: smallItemCellId)
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: hearderViewId)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        return collectionView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        

   
    }
 

}



// MARK: - setup UI
extension RecommendViewController {
    
    fileprivate func setupUI() {
        
        // add collection view
        view.addSubview(collectionView)
    
    }
    
}



extension RecommendViewController: UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 4
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //get cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: smallItemCellId, for: indexPath)
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // section header view
        let hearderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: hearderViewId, for: indexPath)
                
        return hearderView
    }
    
}






