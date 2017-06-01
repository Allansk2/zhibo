//
//  TitleView.swift
//  zhibo
//
//  Created by Regina on 2017-05-29.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

protocol TitleViewDelegate: class {
    func titleView(_ titleView: TitleView, selectedIndex index: Int)
}

private let normalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let highlightColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


class TitleView: UIView {
    
    fileprivate let underLineViewH: CGFloat = 2
    
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
        underLineView.backgroundColor = UIColor(r: highlightColor.0, g: highlightColor.1, b: highlightColor.2)
        
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
    
    
    fileprivate func setupTitleLables() {
        
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
            label.textColor = UIColor(r: normalColor.0, g: normalColor.1, b: normalColor.2)
            label.textAlignment = .center
            
            // 3. set frame
            let lableX: CGFloat = lableW * CGFloat(index)
            label.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            
            // 4. add lable
            addSubview(label)
            titleLabels.append(label)
            
            // 5. add pan gesture
            label.isUserInteractionEnabled = true
//            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLableTap(gesture:)))
        
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLableTap(_:)))
            label.addGestureRecognizer(tapGes)
            
        }
        
    }
    
    
    fileprivate func setupSeparatorLine() {
        // create separator line
        let underLine = UIView()
        underLine.backgroundColor = UIColor(r: normalColor.0, g: normalColor.1, b: normalColor.2)
        let lineH: CGFloat = 0.5
        underLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        
        addSubview(underLine)
        
    }
    
    fileprivate func setupUnderLineView() {
        scrollView.addSubview(underLineView)
        
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor(r: highlightColor.0, g: highlightColor.1, b: highlightColor.2)
        underLineView.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - underLineViewH, width: firstLabel.frame.width, height: underLineViewH)
        
        
    }
    
}


// MARK: - gesture selector
extension TitleView {
    @objc fileprivate func titleLableTap(_ gesture: UITapGestureRecognizer) {
        
        // get tap label
        guard let label = gesture.view as? UILabel else {
            return
        }
        
        if label.tag != chooseLabel {
        
            // get last tap label
            let lastLabel = titleLabels[chooseLabel]
            
            // change text color
            label.textColor = UIColor(r: highlightColor.0, g: highlightColor.1, b: highlightColor.2)
            lastLabel.textColor = UIColor(r: normalColor.0, g: normalColor.1, b: normalColor.2)
            
            // change underlineView frame
            let offsetX = CGFloat(label.tag) * underLineView.frame.width
            UIView.animate(withDuration: 0.2) {
                
                self.underLineView.frame.origin.x = offsetX
            }
            
            chooseLabel = label.tag
            
            // send delegate to update content view
            delegate?.titleView(self, selectedIndex: chooseLabel)
        }
    }
    
}



// MARK: - public func
extension TitleView {
    func setProgress(_ progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        // get source lable and target label
        let sourceLable = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // set underline view frame
        let moveDelta = (targetLabel.frame.origin.x - sourceLable.frame.origin.x) * progress
        underLineView.frame.origin.x = sourceLable.frame.origin.x + moveDelta
        
        // get color difference
        let colorDelta = (highlightColor.0 - normalColor.0, highlightColor.1 - normalColor.1, highlightColor.2 - normalColor.2)
        
        // change new color for source label and target label
        sourceLable.textColor = UIColor(r: highlightColor.0 - colorDelta.0 * progress, g: highlightColor.1 - colorDelta.1 * progress, b: highlightColor.2 - colorDelta.2 * progress)
        
        targetLabel.textColor = UIColor(r: normalColor.0 + colorDelta.0 * progress, g: normalColor.1 + colorDelta.1 * progress, b: normalColor.2 + colorDelta.2 * progress)
        
        // set choose label
        if progress == 1 {
            chooseLabel = targetIndex
        }
        
    }
    
}

