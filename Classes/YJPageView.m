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
    
    if (!_pageVC) {
        [self initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    }
    return _pageVC;
    
}

- (NSMutableArray<YJPageViewObject *> *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
    
}

- (YJPageViewWillAppearBlock)pageViewWillAppear {
    
    YJPageViewWillAppearBlock pageViewWillAppear = ^(YJPageViewController *pageVC) {
        NSLog(@"%d", pageVC.pageViewObject.pageIndex);
    };
    return pageViewWillAppear;
    
}

- (YJPageViewDidSelectBlock)pageViewDidSelect {
    
    if (!_pageViewDidSelect) {
        _pageViewDidSelect = ^(YJPageViewController *pageVC) {
            NSLog(@"当前UIViewController未设置pageView.pageViewDidSelect属性");
        };
    }
    return _pageViewDidSelect;
}

#pragma mark - 设置UIPageViewController
- (void)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary<NSString *,id> *)options {
    
    _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options];
    _pageVC.dataSource = self;
    
}

#pragma mark 刷新PageVC
- (void)reloadPage {
    
    YJPageViewController *pageVC = [self pageViewControllerAtIndex:0];
    NSArray<YJPageViewController *> *array = [NSArray arrayWithObject:pageVC];    
    [self.pageVC setViewControllers:array direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
}

#pragma mark 获取指定位置的YJPageViewController
- (YJPageViewController *)pageViewControllerAtIndex:(NSInteger)pageIndex {
    
    if (self.dataSource.count == 0) {
        return [[YJPageViewController alloc] init];
    }
    
    if (pageIndex < 0) {
        pageIndex = self.dataSource.count - 1;
    } else if (pageIndex == self.dataSource.count){
        pageIndex = 0;
    }
    YJPageViewObject *pageVO = self.dataSource[pageIndex];
    YJPageViewController *pageVC;
    if (pageVO.createPageView == YJPageViewCreateDefault) {
        pageVC = [[pageVO.pageClass alloc] init];
    } else {
        pageVC = [[NSBundle mainBundle] loadNibNamed:YJStringFromClass(pageVO.pageClass) owner:self options:nil].firstObject;
    }
    pageVC.view.backgroundColor = [UIColor whiteColor];
    [pageVC reloadPageWithPageViewObject:pageVO pageView:self];
    return pageVC;
    
}

#pragma mark - UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    YJPageViewController *pageVC = (YJPageViewController *)viewController;
    return [self pageViewControllerAtIndex:pageVC.pageViewObject.pageIndex - 1];
    
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    YJPageViewController *pageVC = (YJPageViewController *)viewController;
    return [self pageViewControllerAtIndex:pageVC.pageViewObject.pageIndex + 1];
    
}

@end
