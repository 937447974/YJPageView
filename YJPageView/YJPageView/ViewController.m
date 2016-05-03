//
//  ViewController.m
//  YJPageView
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//
//  Created by 阳君 on 16/4/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJImagePageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 初始化
    YJPageView *pageView = [[YJPageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:pageView];
    pageView.boundsLayoutTo(self.view);
    // 监听点击
    pageView.pageViewDidSelect = ^(YJPageViewController *pageVC) {
        NSLog(@"点击：%ld", (long)pageVC.pageViewObject.pageIndex);
    };
    // 填充数据源
    for (int i=0; i<5; i++) {
        YJPageViewObject *obj = [YJImagePageViewController pageViewObject];
        [pageView.dataSource addObject:obj];
    }
    [pageView reloadPage];
    
}

@end
