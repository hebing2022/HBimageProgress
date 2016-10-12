//
//  CustomImageView.swift
//  HBimageProgressSwift
//
//  Created by hebing on 16/10/12.
//  Copyright © 2016年 hebing. All rights reserved.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    
    var circularView:CircularLoaderView?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        initcircularView()
        
    }
    
    func initcircularView() {
    
        circularView = CircularLoaderView.init(frame: self.bounds)
        self.addSubview(circularView!)
        
    }
    
    func setProgress(progress: CGFloat) {
        
        print(progress)
        circularView?.progress = progress
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
