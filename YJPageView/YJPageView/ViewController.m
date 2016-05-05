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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 初始化
    YJPageView *pageView = [[YJPageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:pageView];
    pageView.boundsLayoutTo(self.view);
    // 监听
    pageView.pageViewWillAppear = ^(YJPageViewController *pageVC) {
        switch (pageVC.pageViewObject.pageIndex%3) {
            case 0:
                pageVC.view.backgroundColor = [UIColor greenColor];
                break;
            case 1:
                pageVC.view.backgroundColor = [UIColor yellowColor];
                break;
            case 2:
                pageVC.view.backgroundColor = [UIColor redColor];
                break;
                
            default:
                break;
        }
    };
    pageView.pageViewDidSelect = ^(YJPageViewController *pageVC) {
        NSLog(@"点击：%ld", (long)pageVC.pageViewObject.pageIndex);
    };
    // 填充数据源
    for (int i=0; i<5; i++) {
        YJPageViewObject *obj = [YJPageViewController pageViewObject];
        [pageView.dataSource addObject:obj];
    }
    [pageView reloadPage];
    
}

@end
