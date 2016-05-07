//
//  YJPageView.m
//  YJPageView
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//  HomePage:https://github.com/937447974/YJPageView
//
//  Created by 阳君 on 16/4/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJPageView.h"

@interface YJPageView () <UIPageViewControllerDataSource> {
    UIPageViewController *_pageVC; ///< pageVC的备份
    UIPageControl *_pageControl;   ///< pageControl的备份
    NSInteger _appearWillIndex;    ///< 页面将要显示
    NSInteger _appearDidIndex;     ///< 当前页面
}

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;   ///< 轮转图的时间触发器

@end

@implementation YJPageView

#pragma mark - 设置UIPageViewController
- (void)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary<NSString *,id> *)options {
    
    _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options];
    _pageVC.dataSource = self;
    [self insertSubview:_pageVC.view atIndex:0];    
    _pageVC.view.boundsLayoutTo(self);
    [[self superViewController:self.nextResponder] addChildViewController:_pageVC];
    
}

#pragma mark 刷新PageVC
- (void)reloadPage {
    
    _pageControl.numberOfPages = self.dataSource.count;
    [self gotoPageWithIndex:0 animated:NO completion:nil];
   
}

#pragma mark 前往指定界面
- (void)gotoPageWithIndex:(NSInteger)pageIndex animated:(BOOL)animated completion:(void (^)(BOOL))completion {
    
    NSMutableArray<YJPageViewController *> *array = [NSMutableArray array];
    YJPageViewController *pvc = [self pageViewControllerAtIndex:pageIndex];
    if (!pvc) {
        return;
    }
    [array addObject:pvc];
    if (self.pageVC.spineLocation == UIPageViewControllerSpineLocationMid) { // 双页面显示
        pvc = [self pageViewControllerAtIndex:pageIndex+1];
        if (pvc) {
            [array addObject:pvc];
        } else {
            pvc = [self pageViewControllerAtIndex:pageIndex-1];
            if (!pvc) {
                return;
            }
            [array insertObject:pvc atIndex:0];
        }
    }
    UIPageViewControllerNavigationDirection direction =  pageIndex >= _appearDidIndex ?UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;    
    [self.pageVC setViewControllers:array direction:direction animated:animated completion:completion];
    
}

#pragma mark - 辅助方法
#pragma mark 获取当前UIViewController
- (UIViewController *)superViewController:(UIResponder *)nextResponder {
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]])  {
        return [self superViewController:nextResponder.nextResponder];
    }
    return nil;
    
}

#pragma mark 自动轮播
- (void)timeLoop {
    [self gotoPageWithIndex:_appearDidIndex+1 animated:YES completion:nil];
}

#pragma mark 获取指定位置的YJPageViewController
- (YJPageViewController *)pageViewControllerAtIndex:(NSInteger)pageIndex {
    
    if (self.dataSource.count == 0) {
        return nil;
    }
    if (!self.isLoop && (pageIndex < 0 || self.dataSource.count <= pageIndex )) {// 不轮训过滤
        return nil;
    }
    if (pageIndex < 0) {
        pageIndex = self.dataSource.count - 1;
    } else if (pageIndex == self.dataSource.count){
        pageIndex = 0;
    }
    __weak YJPageViewObject *pageVO = self.dataSource[pageIndex];
    pageVO.pageIndex = pageIndex;
    YJPageViewController *pageVC;
    if (pageVO.createPageView == YJPageViewCreateDefault) {
        pageVC = [[pageVO.pageClass alloc] init];
    } else {
        pageVC = [[NSBundle mainBundle] loadNibNamed:YJStringFromClass(pageVO.pageClass) owner:self options:nil].firstObject;
    }
    pageVC.view.backgroundColor = [UIColor whiteColor];
    __weak YJPageView *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [pageVC reloadPageWithPageViewObject:pageVO pageView:weakSelf];
        });
    });
    
    return pageVC;
    
}

#pragma mark 点击UIPageControl
- (void)onClickPageControl:(UIPageControl *)pageControl {
    
    if (_pageControl.currentPage != _appearDidIndex) {
        [self gotoPageWithIndex:_pageControl.currentPage animated:YES completion:nil];
    }
    
}

#pragma mark - KOV
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"] && _isDisableBounces && (_appearDidIndex == 0 || _appearDidIndex == self.dataSource.count-1)) {
        CGPoint contentOffset = self.scrollView.contentOffset;
        if (_appearDidIndex == 0) { // 首页
            switch (self.pageVC.navigationOrientation) {
                case UIPageViewControllerNavigationOrientationHorizontal:
                    if (contentOffset.x < self.frame.size.width) {
                        contentOffset.x = self.frame.size.width;
                        [self.scrollView setContentOffset:contentOffset animated:NO];
                    }
                    break;
                case UIPageViewControllerNavigationOrientationVertical:
                    if (contentOffset.y<self.frame.size.height) {
                        contentOffset.y = self.frame.size.height;
                        [self.scrollView setContentOffset:contentOffset animated:NO];
                    }
                    break;
            }
        }
        if (_appearDidIndex == self.dataSource.count-1) { // 尾页
            switch (self.pageVC.navigationOrientation) {
                case UIPageViewControllerNavigationOrientationHorizontal:
                    if (contentOffset.x > self.frame.size.width) {
                        contentOffset.x = self.frame.size.width;
                        [self.scrollView setContentOffset:contentOffset animated:NO];
                    }
                    break;
                case UIPageViewControllerNavigationOrientationVertical:
                    if (contentOffset.y>self.frame.size.height) {
                        contentOffset.y = self.frame.size.height;
                        [self.scrollView setContentOffset:contentOffset animated:NO];
                    }
                    break;
            }
        }
    }
    
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

#pragma mark - getter and setter
- (UIPageViewController *)pageVC {
    
    if (!_pageVC) {
        [self initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    }
    return _pageVC;
    
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        [self insertSubview:_pageControl aboveSubview:self.pageVC.view]; // 显示
        [_pageControl addObserver:self forKeyPath:@"currentPage" options:NSKeyValueObservingOptionNew context:nil];
        [_pageControl addTarget:self action:@selector(onClickPageControl:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
    
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        for (UIView *v in self.pageVC.view.subviews) {
            if ([v isKindOfClass:[UIScrollView class]]) {
                _scrollView = (UIScrollView *)v;
            }
        }
    }
    return _scrollView;
    
}

- (NSMutableArray<YJPageViewObject *> *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
    
}

- (YJPageViewAppearBlock)pageViewAppear {
    
    __weak YJPageViewAppearBlock weakBlock = _pageViewAppear;
    YJPageViewAppearBlock pageViewAppear = ^(YJPageViewController *pageVC, YJPageViewAppear appeear) {
        switch (appeear) {
            case YJPageViewAppearWill:
                _appearWillIndex = pageVC.pageViewObject.pageIndex;
                _pageControl.currentPage = _appearWillIndex;
                break;
            case YJPageViewAppearDid:
                _appearDidIndex = pageVC.pageViewObject.pageIndex;
                _pageControl.currentPage = _appearDidIndex;
                break;
        }
        if (weakBlock) {
            weakBlock(pageVC, appeear);
        }
    };
    return pageViewAppear;
    
}

- (YJPageViewDidSelectBlock)pageViewDidSelect {
    
    if (!_pageViewDidSelect) {
        _pageViewDidSelect = ^(YJPageViewController *pageVC) {
            NSLog(@"当前UIViewController未设置pageView.pageViewDidSelect属性");
        };
    }
    return _pageViewDidSelect;
    
}

- (void)setIsDisableScrool:(BOOL)isDisableScrool {
    
    _isDisableScrool = isDisableScrool;
    self.scrollView.scrollEnabled = !_isDisableScrool;
    
}

- (void)setIsDisableBounces:(BOOL)isDisableBounces {
    
    _isDisableBounces = isDisableBounces;
    if (_isDisableBounces) {
        self.isLoop = NO;
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    } else {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    
    if (timeInterval > 0) {
        self.isLoop = YES;
        if (self.isDisableBounces) {
            self.isDisableBounces = NO;
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timeLoop) userInfo:nil repeats:YES];
        // [self.timer setFireDate:[NSDate date]];// 继续
    } else {
        [self.timer setFireDate:[NSDate distantFuture]];// 暂停
    }
    
}

@end
