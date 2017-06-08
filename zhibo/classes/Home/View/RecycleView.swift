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
 
    var timer: Timer?
    
    var recycleModels: [RecycleModel]? {
        didSet {
            
            // reload date
            self.collectionView.reloadData()
            
            // set page controll
            pageControll.numberOfPages = recycleModels?.count ?? 0
            
            
            let indexPath = NSIndexPath(item: (recycleModels?.count ?? 0) * 1000, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            removeTimer()
            addTimer()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // important: let view not auto resizing as parent view!
        autoresizingMask = UIViewAutoresizing()
        
        // register cell
        collectionView.register(UINib(nibName: "RecycleCell", bundle: nil), forCellWithReuseIdentifier: recycleCellId)
        
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
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (recycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.item % (recycleModels!.count)
        
        let recycleModel = recycleModels![index]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recycleCellId, for: indexPath) as! RecycleCell
        cell.recycleModel = recycleModel
         
        return cell
        
    }
    
}

extension RecycleView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // get scroll content off
        let offsetX = scrollView.contentOffset.x
        
        // calculate current index
        let currentIndex = Int(offsetX / scrollView.bounds.width + 0.5) % (recycleModels!.count )
        
        pageControll.currentPage = currentIndex
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        removeTimer()
        addTimer()
    }
}

extension RecycleView {

    fileprivate func addTimer() {
        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(viewNext), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    fileprivate func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func viewNext() {
        
        var offsetX = collectionView.contentOffset.x
        offsetX += collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
     
    }
    
}


