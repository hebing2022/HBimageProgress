//
//  CircularLoaderView.swift
//  HBimageProgressSwift
//
//  Created by hebing on 16/10/12.
//  Copyright © 2016年 hebing. All rights reserved.
//

import Foundation
import UIKit

class CircularLoaderView: UIView, CAAnimationDelegate {
    
    var progressLayer: CAShapeLayer?
    
    
    var progress:CGFloat? {
        
        didSet {
            
            progressLayer?.strokeEnd = progress!
            if progress == 1 {
                
                addMaskAnimation()
            }
        }

    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        initProgressLayer()
        
    }
   
    //创建Layer
    func initProgressLayer() {
        
        progressLayer = CAShapeLayer.init()
        progressLayer?.fillColor = UIColor.clear.cgColor;
        progressLayer?.lineWidth = 2.0;
        progressLayer?.strokeColor = UIColor.orange.cgColor;
        progressLayer?.strokeEnd = 0;
        
        let path = UIBezierPath.init()
        path.addArc(withCenter: self.center, radius: 30, startAngle:0, endAngle:CGFloat(M_PI*2) , clockwise: true)
        progressLayer?.path = path.cgPath
        self.layer .addSublayer(progressLayer!)
    }
    
    //图片加载动画
    func addMaskAnimation() {
        
        self.backgroundColor = UIColor.clear
        progressLayer?.removeAllAnimations()
        progressLayer?.removeFromSuperlayer()
        
        self.superview?.layer.mask = progressLayer;
        
        let center = CGPoint.init(x:self.bounds.midX , y: self.bounds.midY)
        let fromValue = progressLayer?.lineWidth
        let toValue = sqrt((center.x * center.x) + (center.y * center.y))
        
        let animation = CABasicAnimation.init(keyPath: "lineWidth")
        animation.fromValue = fromValue;
        animation.toValue = toValue;
        
        let path = UIBezierPath.init()
        path.addArc(withCenter: self.center, radius: toValue/2, startAngle:0, endAngle:CGFloat(M_PI*2) , clockwise: true)
        
        let animation1 = CABasicAnimation.init(keyPath: "path")
        animation1.fromValue = progressLayer?.path
        animation1.toValue = path.cgPath;
        
        let group = CAAnimationGroup.init()
        group.animations = [animation,animation1]
        group.duration = 1;
        group.delegate = self;
        group.isRemovedOnCompletion = false;
        group.fillMode = kCAFillModeForwards;
        progressLayer?.add(group, forKey: nil)
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        self.superview?.layer.mask = nil
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
