//
//  ViewController.m
//  YJPageView
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//  HomePage:https://github.com/937447974/YJPageView
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
    
    [self testPressure];
    
}

- (void)test {
    
    // 初始化
    YJPageView *pageView = [[YJPageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:pageView];
    pageView.boundsLayoutTo(self.view);
    
    // 启用UIPageControl
    //    pageView.pageControl.widthLayout.equalToConstant(100);
    //    pageView.pageControl.heightLayout.equalToConstant(30);
    //    pageView.pageControl.centerLayoutTo(self.view);
    //    pageView.pageControl.pageIndicatorTintColor = [UIColor blueColor];
    
    // 修改UIPageViewController
    [pageView initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pageView.isLoop = YES;
    //    pageView.isDisableBounces = YES;
    pageView.timeInterval = 0.02;
    // 监听
    pageView.pageViewAppear = ^(YJPageViewController *pageVC, YJPageViewAppear appear) {
        switch (appear) {
            case YJPageViewAppearWill: {
                //                NSLog(@"Will：%ld", (long)pageVC.pageViewObject.pageIndex);
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
                }
                break;
            }
            case YJPageViewAppearDid:
                //                NSLog(@"Did：%ld", (long)pageVC.pageViewObject.pageIndex);
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

#pragma mark 压力测试
- (void)testPressure {
    
    // 初始化
    YJPageView *pageView = [[YJPageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:pageView];
    pageView.boundsLayoutTo(self.view);
    pageView.isLoop = YES;
    pageView.timeInterval = 0.02; // 峰值，内存释放稳定
    // 监听
    pageView.pageViewAppear = ^(YJPageViewController *pageVC, YJPageViewAppear appear) {
        switch (appear) {
            case YJPageViewAppearWill: {
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
                }
                break;
            }
            case YJPageViewAppearDid:
                break;
        }
    };
    pageView.pageViewDidSelect = ^(YJPageViewController *pageVC) {
        NSLog(@"点击：%ld", (long)pageVC.pageViewObject.pageIndex);
    };
    // 填充数据源
    for (int i=0; i<10; i++) {
        YJPageViewObject *obj = [YJPageViewController pageViewObject];
        [pageView.dataSource addObject:obj];
    }
    [pageView reloadPage];
    
}

@end
