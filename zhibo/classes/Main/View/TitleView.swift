//
//  TitleView.swift
//  zhibo
//
//  Created by Regina on 2017-05-29.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

protocol TitleViewDelegate: class {
    func titleView(titleView: TitleView, selectedIndex index: Int)
}

private let underLineViewH: CGFloat = 2

class TitleView: UIView {
    
    fileprivate var chooseLabel: Int = 0
    
    fileprivate var titles: [String]
    
    weak var delegate: TitleViewDelegate?
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView =  UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    fileprivate lazy var underLineView: UIView = {
        let underLineView = UIView()
        underLineView.backgroundColor = UIColor.orange
        
        return underLineView
    }()
    
    fileprivate lazy var titleLabels: [UILabel] =  [UILabel]()
    
    
    // MARK - custom init
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
       
        // setup UI 
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}


// MARK: - setup UI
extension TitleView {
    
    fileprivate func setupUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // add labels
        setupTitleLables()
        
        // add separator
        setupSeparatorLine()
        
        // add underline view
        setupUnderLineView()
    }
    
    
    private func setupTitleLables() {
        
        let lableW: CGFloat = frame.width / CGFloat(titles.count)
        let lableH: CGFloat = frame.height - underLineViewH
        let lableY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            // 1. create UILable
            let label = UILabel()
            
            // 2. set lable attributes
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            // 3. set frame
            let lableX: CGFloat = lableW * CGFloat(index)
            label.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            
            // 4. add lable
            addSubview(label)
            titleLabels.append(label)
            
            // 5. add pan gesture
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLableTap(gesture:)))
 
            label.addGestureRecognizer(tapGes)
            
        }
        
    }
    
    
    private func setupSeparatorLine() {
        // create separator line
        let underLine = UIView()
        underLine.backgroundColor = UIColor.darkGray
        let lineH: CGFloat = 0.5
        underLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        
        addSubview(underLine)
        
    }
    
    private func setupUnderLineView() {
        scrollView.addSubview(underLineView)
        
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        underLineView.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - underLineViewH, width: firstLabel.frame.width, height: underLineViewH)
        
        
    }
    
}


// MARK: - gesture selector
extension TitleView {
    @objc fileprivate func titleLableTap(gesture: UITapGestureRecognizer) {
        
        // get tap label
        guard let label = gesture.view as? UILabel else {
            return
        }
        
        // get last tap label
        let lastLabel = titleLabels[chooseLabel]
        
        // change text color
        label.textColor = UIColor.orange
        lastLabel.textColor = UIColor.darkGray
        
        // change underlineView frame
        let offsetX = CGFloat(label.tag) * underLineView.frame.width
        UIView.animate(withDuration: 0.2) { 
            
            self.underLineView.frame.origin.x = offsetX
        }
        
        chooseLabel = label.tag
        
        // send delegate to update content view
        delegate?.titleView(titleView: self, selectedIndex: chooseLabel)
    }
    
}


