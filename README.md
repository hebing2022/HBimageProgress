##自定义的一个图片加载动画，包括swift和OC
####1、首先要去加载图片，用的SDWeb
```
- (CustomImageView *)customImageview
{
    if (!_customImageview) {
        
        _customImageview = [[CustomImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
        _customImageview.contentMode = UIViewContentModeScaleAspectFit;
        NSString *url = @"http://i4.hexunimg.cn/2015-02-16/173423543.jpg";
        [_customImageview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            [_customImageview setProgress:(CGFloat)receivedSize/expectedSize];
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //第一次运行可以把这里隐藏掉，这里只是为了避免图片缓存看不到效果
            [_customImageview setProgress:1];
        }];
        
    }
    return _customImageview;
}
```
####创建一个loadingLayer,通过图片加载的进度来控制
```
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
```
####最后就是加载图片的动画了，通过imageView的Mask来控制
```
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
```
##这里是OC版的，Swift版就不介绍了，都是差不多的
