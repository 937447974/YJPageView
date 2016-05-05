//
//  YJPageView.h
//  YJPageView
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//
//  Created by 阳君 on 16/4/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

// homepage = "https://github.com/937447974/YJPageView"

#import <UIKit/UIKit.h>
#import "YJPageViewObject.h"
#import "YJPageViewController.h"

NS_ASSUME_NONNULL_BEGIN

/** YJPageViewController显示通知*/
typedef void (^ YJPageViewWillAppearBlock)(YJPageViewController *pageVC);
/** YJPageViewController点击通知*/
typedef void (^ YJPageViewDidSelectBlock)(YJPageViewController *pageVC);


/** page view*/
@interface YJPageView : UIView

@property (nonatomic) BOOL isLoop; ///< 是否循环展示、默认No不循环
@property (nonatomic, strong) NSMutableArray<YJPageViewObject *> *dataSource; ///< 数据源
@property (nonatomic, copy) YJPageViewWillAppearBlock pageViewWillAppear; ///< YJPageViewController显示通知
@property (nonatomic, copy) YJPageViewDidSelectBlock pageViewDidSelect;   ///< YJPageViewController点击通知

@property (nonatomic, strong, readonly) UIPageViewController *pageVC;         ///< 显示的UIPageViewController

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
