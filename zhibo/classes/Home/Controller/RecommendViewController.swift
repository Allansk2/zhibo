//
//  RecommendViewController.swift
//  zhibo
//
//  Created by Regina on 2017-05-31.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit


private let recycleViewH = ScreenW * 3 / 8
private let recommendGameViewH: CGFloat = 90
 

class RecommendViewController: BaseAnchorViewController {

    fileprivate lazy var recommenVM: RecommendViewModel = RecommendViewModel()
    
    fileprivate lazy var recycleView: RecycleView = {
        
        let recycleView = RecycleView.recycleView()
        recycleView.frame = CGRect(x: 0, y: -(recycleViewH + recommendGameViewH), width: ScreenW, height: recycleViewH)
        
        return recycleView
    }()
    
    fileprivate lazy var recommendGameView: RecommendGameView = {
        
        let recommendGameView = RecommendGameView.recommendGameView()
        recommendGameView.frame = CGRect(x: 0, y: -recommendGameViewH, width: ScreenW, height: recommendGameViewH)
        
        return recommendGameView
    }()
    


}



// MARK: - setup UI
extension RecommendViewController {
    
    override func setupUI() {
        
        super.setupUI()
        
        // add recycleview
        collectionView.addSubview(recycleView)
        
        // add recommendGameView
        collectionView.addSubview(recommendGameView)
        
        // set collection insert
        collectionView.contentInset = UIEdgeInsets(top: recycleViewH + recommendGameViewH, left: 0, bottom: 0, right: 0)
    
    }
    
}


// MARK: - load data
extension RecommendViewController {
    
    override func loadData(){
        
        baseVM = recommenVM
        
        recommenVM.loadData {
            
            // update UI
            self.collectionView.reloadData()
            
            // set recommomeng view data
            
            var groups = self.recommenVM.anchorGroup
            
            // remove first two item
            groups.removeFirst()
            groups.removeFirst()
            
            // add more
            let more: Anchor = Anchor()
            more.tag_name = "更多分类"
            
            groups.append(more)
            
            self.recommendGameView.anchorGroup = groups
            
            self.dataLoaded()
            
        }
        
        recommenVM.requestRecycleViewData { 
            
            self.recycleView.recycleModels = self.recommenVM.recycleRooms
        }
    }
    
}



// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension RecommendViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //get cell
        var cell = CollectionViewBaseCell()
        if indexPath.section == 1 {
            
            // get room data
            let group = recommenVM.anchorGroup[indexPath.section]
            let room = group.rooms[indexPath.item]
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId, for: indexPath) as! CollectionCell
            cell.room = room
            return cell

        }else {
            
            return super.collectionView(collectionView, cellForItemAt: indexPath)
         
            
        }
        
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: itemW, height: itemH)
        }
         return CGSize(width: itemW, height: smallItemH)
    }
}







