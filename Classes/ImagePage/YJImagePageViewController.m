//
//  YJImagePageViewController.m
//  YJPageView
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//  HomePage:https://github.com/937447974/YJPageView
//
//  Created by 阳君 on 16/5/7.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJImagePageViewController.h"

@interface YJImagePageViewController ()

@end

@implementation YJImagePageViewController


#pragma mark - IBAction 点击图片
- (IBAction)onClickImageView:(id)sender {
    self.pageView.pageViewDidSelect(self);
}

#pragma mark - YJPageView

- (void)reloadPageWithPageViewObject:(YJPageViewObject *)pageViewObject pageView:(YJPageView *)pageView {
    
    [super reloadPageWithPageViewObject:pageViewObject pageView:pageView];
    YJImagePageModel *model = pageViewObject.pageModel;
    self.imageView.image = [UIImage imageNamed:model.imageNamed];
    self.imageView.userInteractionEnabled = model.isOnClick;
    
}

@end
