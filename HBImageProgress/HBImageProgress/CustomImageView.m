//
//  CustomImageView.m
//  HBImageProgress
//
//  Created by hebing on 16/10/12.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import "CustomImageView.h"
#import "CircularLoaderView.h"

@interface CustomImageView()

@property (nonatomic, strong) CircularLoaderView *circolarView;

@end
@implementation CustomImageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.circolarView];
        
    }
    
    return self;
}
- (CircularLoaderView *)circolarView
{
    if (!_circolarView) {
        
        _circolarView = [[CircularLoaderView alloc] initWithFrame:self.bounds];
    }
    
    return _circolarView;
}
- (void)setProgress:(CGFloat)progress
{
    _circolarView.progress = progress;
    
    if (progress == 1) {
        //loading完之后就加载Mask
        [_circolarView performSelector:@selector(addMaskAnimation) withObject:nil afterDelay:0.1f];
    }
}
@end
