//
//  BaseViewController.swift
//  zhibo
//
//  Created by Regina on 2017-06-10.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // content view hold views of data
    var contentView: UIView?
  
    fileprivate lazy var imageView: UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
  
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
     }
 
}


extension BaseViewController {
    
    func setupUI() {
        
        // hide content view
        contentView?.isHidden = true
        
        view.addSubview(imageView)
        
        imageView.startAnimating()
        
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        
    }
    
    func dataLoaded() {
        
        imageView.startAnimating()
        
        imageView.isHidden = true
        
        contentView?.isHidden = false
        
    }
    
}
