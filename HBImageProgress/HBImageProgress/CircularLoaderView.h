//
//  CircularLoaderView.h
//  HBImageProgress
//
//  Created by hebing on 16/10/12.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularLoaderView : UIView

@property (nonatomic, assign) CGFloat progress;

- (void)addMaskAnimation;

@end
