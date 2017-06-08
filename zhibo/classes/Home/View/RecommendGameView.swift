//
//  RecommendGameView.swift
//  zhibo
//
//  Created by Regina on 2017-06-07.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class RecommendGameView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    var anchorGroup: [Anchor]? {
        didSet {
            
            // remove first two item
            anchorGroup?.removeFirst()
            anchorGroup?.removeFirst()
            
            // add more
            let more: Anchor = Anchor()
            more.tag_name = "更多分类"
            
            anchorGroup?.append(more)
            
            collectionView.reloadData()
            
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // important: let view not auto resizing as parent view!
        autoresizingMask = UIViewAutoresizing()
 
        collectionView.register(UINib(nibName: "RecommendGameCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    

}


// create class function to init
extension RecommendGameView {
    
    class func recommendGameView()-> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
    
}



// MARK: - UICollectionViewDataSource
extension RecommendGameView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroup?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RecommendGameCell
        
        cell.anchor = anchorGroup![indexPath.item]
         
        return cell
    }
    
    
}
