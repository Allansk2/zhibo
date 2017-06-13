//
//  MenuView.swift
//  zhibo
//
//  Created by Regina on 2017-06-09.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

private let menuCellId = "menuCellId"

class MenuView: UIView {
    
    var anchorGroup: [Anchor]? {
        didSet{
            anchorGroup?.remove(at: 0)
            
//            for anchor in anchorGroup! {
//                anchorGroup?.append(anchor)
//            }
            
            collectionView.reloadData()
        }
    }


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // important: let view not auto resizing as parent view!
        autoresizingMask = UIViewAutoresizing()
     
        collectionView.register(UINib(nibName: "MenuViewCell", bundle: nil), forCellWithReuseIdentifier: menuCellId)
        
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
        
    }
    
    
}

extension MenuView {
    
    class func menuView() -> MenuView {
        
        return Bundle.main.loadNibNamed("MenuView", owner: nil, options: nil)?.first as! MenuView
        
    }
}




extension MenuView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if anchorGroup == nil {
            return 0
        }
        
        let count = (anchorGroup!.count - 1) / 8 + 1
        pageControll.numberOfPages = count
        pageControll.isHidden = (count == 1)
        return count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellId, for: indexPath) as! MenuViewCell
 
        let startIndex = indexPath.item * 8
        let endIndex = min((indexPath.item + 1) * 8 - 1, anchorGroup!.count - 1)
        
        let cellAnchorGroup = Array(anchorGroup![startIndex...endIndex])
        cell.anchorGroup = cellAnchorGroup
        
        
        return cell
    }
    
    
}


extension MenuView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // get scroll content off
        let offsetX = scrollView.contentOffset.x
        
        // calculate current index
        let currentIndex = Int(offsetX / scrollView.bounds.width + 0.5)
        
        pageControll.currentPage = currentIndex    }
  
}






