//
//  RecycleView.swift
//  zhibo
//
//  Created by Regina on 2017-06-05.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit


private let recycleCellId = "recycleCellId"

class RecycleView: UIView {
 
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControll: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIViewAutoresizing()
        
        // register cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: recycleCellId)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // set collectionview flow layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
 
    }
    
}

// create class function to init
extension RecycleView {
    
    class func recycleView()-> RecycleView {
        return Bundle.main.loadNibNamed("RecycleView", owner: nil, options: nil)?.first as! RecycleView
    }
    
}



// MARK: - UICollectionViewDataSource
extension RecycleView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recycleCellId, for: indexPath)
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.green
        
        return cell
        
    }
    
}

