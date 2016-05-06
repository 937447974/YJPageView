//
//  YJPageView.m
//  YJPageView
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//
//  Created by 阳君 on 16/4/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJPageView.h"

@interface YJPageView () <UIPageViewControllerDataSource> {
    UIPageViewController *_pageVC; ///< pageVC的备份
    NSInteger _appearWillIndex;    ///< 页面将要显示
    NSInteger _appearDidIndex;     ///< 当前页面
}

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation YJPageView

#pragma mark - 设置UIPageViewController
- (void)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary<NSString *,id> *)options {
    
    _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options];
    _pageVC.dataSource = self;
    [self addSubview:_pageVC.view];
    _pageVC.view.boundsLayoutTo(self);
    [[self superViewController:self.nextResponder] addChildViewController:_pageVC];
    
}

- (UIViewController *)superViewController:(UIResponder *)nextResponder {
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]])  {
        return [self superViewController:nextResponder.nextResponder];
    }
    NSLog(@"YJPageView需添加到UIViewController上");
    return nil;
    
}

#pragma mark 刷新PageVC
- (void)reloadPage {
    
    NSArray<YJPageViewController *> *array;
    if (self.pageVC.spineLocation == UIPageViewControllerSpineLocationMid) { // 双页面显示
        if (self.dataSource.count <= 1) {
            return;
        }
        array = @[[self pageViewControllerAtIndex:0], [self pageViewControllerAtIndex:1]];
    } else {
        array = @[[self pageViewControllerAtIndex:0]];
    }
    [self.pageVC setViewControllers:array direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
}

#pragma mark 禁用阻力效果
- (void)disableBounces {
    
    for (UIView *v in self.pageVC.view.subviews) {
        if ([v isKindOfClass:[UIScrollView class]]) {
            self.scrollView = (UIScrollView *)v;
            [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
//            sv.bounces = NO;
//            CGSize contentSize = sv.contentSize;
//            contentSize.width += 10;
//            sv.contentSize = contentSize;
//            CGPoint contentOffset = sv.contentOffset;
//            contentOffset.x += 5;
//            sv.contentOffset = contentOffset;
        }
    }
    
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
    YJPageViewObject *pageVO = self.dataSource[pageIndex];
    pageVO.pageIndex = pageIndex;
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

#pragma mark - KOV
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        NSLog(@"%@", NSStringFromCGPoint(self.scrollView.contentOffset));
        //        (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;
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

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.dataSource.count;
}

#pragma mark - getter and setter
- (UIPageViewController *)pageVC {
    
    if (!_pageVC) {
        [self initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:nil];
    }
    return _pageVC;
    
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
        // ---------------
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

@end
