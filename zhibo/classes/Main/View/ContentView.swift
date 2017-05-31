//
//  ContentView.swift
//  zhibo
//
//  Created by Regina on 2017-05-29.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

private let cellID = "cellID"
class ContentView: UIView {
    
    fileprivate var childVCs: [UIViewController]
    fileprivate weak var parentVC: UIViewController?
    fileprivate var startOffsetX: CGFloat = 0

    fileprivate lazy var collectionView : UICollectionView = { [weak self] in
        
        // 1. set flow layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2. create collectionview
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        return collectionView
    }()

    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController?) {
        
        self.childVCs = childVCs
        self.parentVC = parentVC
        
        super.init(frame: frame)
        
        
        // setup UI
        setupUI()
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK: - setup UI
extension ContentView {
    
    fileprivate func setupUI() {
        
        // 1. add all childVC
        for childVC in childVCs {
            parentVC?.addChildViewController(childVC)
        }
        
        // 2. add connectionView
        addSubview(collectionView)
        collectionView.frame = bounds
        
        
    }
    
}


// MARK: - collection datasource
extension ContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.row]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
    
}



// MARK: - public func
extension ContentView {
    
    func setCurrentVC(index: Int)  {

        let offsetX = CGFloat(index) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
}

extension ContentView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // get start offset 
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
      
        let currentOffsetX = scrollView.contentOffset.x
        if currentOffsetX > startOffsetX {
            sourceIndex = Int(floor(currentOffsetX / collectionView.frame.width))
            progress = CGFloat(currentOffsetX) / collectionView.frame.width - CGFloat(sourceIndex)
            targetIndex = sourceIndex + 1
            if targetIndex > childVCs.count - 1 {
                targetIndex = childVCs.count - 1
            }
            if (startOffsetX + collectionView.frame.width) == currentOffsetX {
                progress = 1
                targetIndex = sourceIndex
            }
        }else {
            targetIndex = Int(floor(currentOffsetX / collectionView.frame.width))
            sourceIndex = targetIndex + 1
            progress = 1 - (CGFloat(currentOffsetX) / collectionView.frame.width - CGFloat(targetIndex))
  
            if sourceIndex > childVCs.count - 1 {
                sourceIndex = childVCs.count - 1
            }
            if (startOffsetX - collectionView.frame.width) == currentOffsetX {
                progress = 1
                sourceIndex = targetIndex
            }
        }
        
        // pass variables to title view
        print("progress \(progress) sourceIndex \(sourceIndex) targetIndex \(targetIndex) ")
        
        
    }
    
    
}






