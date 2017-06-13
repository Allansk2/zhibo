//
//  MenuViewCell.swift
//  zhibo
//
//  Created by Regina on 2017-06-10.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

private let gameCellId = "gameCellId"

class MenuViewCell: UICollectionViewCell {

    
    var anchorGroup: [Anchor]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "RecommendGameCell", bundle: nil), forCellWithReuseIdentifier: gameCellId)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
}


extension MenuViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return anchorGroup?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellId, for: indexPath) as! RecommendGameCell
            
            // set data to cell
            cell.base = anchorGroup![indexPath.item]
 
            return cell
            
            
    }
}
