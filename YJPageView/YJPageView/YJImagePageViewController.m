//
//  YJImagePageViewController.m
//  YJPageView
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//
//  Created by 阳君 on 16/5/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJImagePageViewController.h"

@interface YJImagePageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation YJImagePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)reloadPageWithPageViewObject:(YJPageViewObject *)pageViewObject pageView:(YJPageView *)pageView {
    
    [super reloadPageWithPageViewObject:pageViewObject pageView:pageView];
    NSLog(@"%ld", (long)pageViewObject.pageIndex);
    self.imageView.image = [UIImage imageNamed:@"LaunchImage"];
    
}

#pragma mark 点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    self.pageView.pageViewDidSelect(self);
    
}

@end
