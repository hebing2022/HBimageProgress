//
//  ViewController.swift
//  HBimageProgressSwift
//
//  Created by hebing on 16/10/12.
//  Copyright © 2016年 hebing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "http://easyread.ph.126.net/k_eW-I4ALlzo4Dp5YLQ8Qw==/7916860852475834715.jpg"
        let customImageView = CustomImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width))
        customImageView.contentMode = .scaleAspectFit
        customImageView.sd_setImage(with: NSURL.init(string: url) as URL!, placeholderImage: nil, options: SDWebImageOptions(rawValue: UInt(0)), progress: { (receivedSize, expectedSize) in
            
                customImageView.setProgress(progress: CGFloat(receivedSize)/CGFloat(expectedSize))
            
            }) { (image, error, cacheType, imageUrl) in
                
                //第一次运行可以把这里隐藏掉，这里只是为了避免图片缓存看不到效果
                customImageView.setProgress(progress: CGFloat(1))
        }
        self.view.addSubview(customImageView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

