//
//  YJPageView.h
//  YJPageView
//
//  Created by admin on 16/4/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJPageViewObject.h"
#import "YJPageViewController.h"

NS_ASSUME_NONNULL_BEGIN

/** YJPageViewController通知YJPageView*/
typedef void (^ YJPageViewWillAppearBlock)(YJPageViewController *pageVC);
/** YJPageViewController通知当前ViewController*/
typedef void (^ YJPageViewDidSelectBlock)(YJPageViewController *pageVC);


/** page view*/
@interface YJPageView : UIView

@property (nonatomic, strong) NSMutableArray<YJPageViewObject *> *dataSource; ///< 数据源
@property (nonatomic, strong, readonly) UIPageViewController *pageVC; ///< 显示的UIPageViewController

/** YJPageViewController通知YJPageView*/
@property (nonatomic, copy, readonly) YJPageViewWillAppearBlock pageViewWillAppear;
/** YJPageViewController通知当前ViewController*/
@property (nonatomic, copy) YJPageViewDidSelectBlock pageViewDidSelect;

/**
 *  修改pageVC时可使用此方法
 *
 *  @param style The style for transitions between pages.
 *  @param navigationOrientation The orientation of the page-by-page navigation.
 *  @param options A dictionary of options. For keys, see Options Keys.
 *
 *  @return void
 */
- (void)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(nullable NSDictionary<NSString *, id> *)options;

/**
 *  刷新pageVC
 *
 *  @return void
 */
- (void)reloadPage;

@end

NS_ASSUME_NONNULL_END
