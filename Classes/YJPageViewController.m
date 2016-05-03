//
//  YJPageViewController.m
//  YJPageView
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJPageViewController.h"
#import "YJPageViewObject.h"
#import "YJPageView.h"

@interface YJPageViewController ()

@end

@implementation YJPageViewController

#pragma mark - super
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.pageView.pageViewWillAppear(self);
    
}

#pragma mark - 刷新界面
- (void)reloadPageWithPageViewObject:(YJPageViewObject *)pageViewObject pageView:(YJPageView *)pageView {
    
    self.pageViewObject = pageViewObject;
    self.pageView = pageView;
    
}

@end
