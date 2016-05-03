//
//  YJPageView.m
//  YJPageView
//
//  Created by admin on 16/4/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJPageView.h"

@interface YJPageView () <UIPageViewControllerDataSource> {
    UIPageViewController *_pageVC;///< pageVC的备份
}
@end

@implementation YJPageView

#pragma mark - getter and setter
- (UIPageViewController *)pageVC {
    
    if (_pageVC == nil) {
        [self initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    }
    return _pageVC;
    
}

- (void)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary<NSString *,id> *)options {
    
    _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options];
    _pageVC.dataSource = self;
    
}

#pragma mark - UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    return nil;
    
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    return nil;
    
}

@end
