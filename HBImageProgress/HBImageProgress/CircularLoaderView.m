//
//  CircularLoaderView.m
//  HBImageProgress
//
//  Created by hebing on 16/10/12.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import "CircularLoaderView.h"
@interface CircularLoaderView()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end
@implementation CircularLoaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        [self.layer addSublayer:self.progressLayer];
    }
    
    return self;
}
- (CAShapeLayer *)progressLayer
{
    if (!_progressLayer) {
        
        _progressLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:self.center radius:30 startAngle:0 endAngle:M_PI*2 clockwise:YES];
        _progressLayer.path = path.CGPath;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.lineWidth = 2.0f;
        _progressLayer.strokeColor = [UIColor orangeColor].CGColor;
        _progressLayer.strokeEnd = 0;
        
    }
    
    return _progressLayer;
}
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    _progressLayer.strokeEnd = progress;
}
- (void)addMaskAnimation
{
    self.backgroundColor = [UIColor clearColor];
    [_progressLayer removeAllAnimations];
    [_progressLayer removeFromSuperlayer];
    
    self.superview.layer.mask = _progressLayer;
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat fromValue = _progressLayer.lineWidth;
    CGFloat toValue = sqrt((center.x * center.x) + (center.y * center.y));
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    animation.fromValue = @(fromValue);
    animation.toValue = @(toValue);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:self.center radius:toValue/2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation1.fromValue = (__bridge id _Nullable)(_progressLayer.path);
    animation1.toValue = (__bridge id _Nullable)(path.CGPath);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation,animation1];
    group.duration = 1;
    group.delegate = self;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [_progressLayer addAnimation:group forKey:nil];
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //self.superview.layer.mask = nil;
}
@end
