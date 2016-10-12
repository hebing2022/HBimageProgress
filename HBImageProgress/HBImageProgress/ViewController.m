//
//  ViewController.m
//  HBImageProgress
//
//  Created by hebing on 16/10/12.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import "ViewController.h"
#import "CustomImageView.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()

@property (nonatomic, strong) CustomImageView *customImageview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.view addSubview:self.customImageview];

}
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
