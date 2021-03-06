//
//  YJPageView.h
//  YJPageView
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//  HomePage:https://github.com/937447974/YJPageView
//
//  Created by 阳君 on 16/4/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJPageViewObject.h"
#import "YJPageViewController.h"

NS_ASSUME_NONNULL_BEGIN

/** 界面显示情况*/
typedef NS_ENUM(NSInteger, YJPageViewAppear) {
    YJPageViewAppearWill, ///< viewWillAppear
    YJPageViewAppearDid   ///< viewDidAppear
};


/** YJPageViewController显示通知*/
typedef void (^ YJPageViewAppearBlock)(YJPageViewController *pageVC, YJPageViewAppear appear);
/** YJPageViewController点击通知*/
typedef void (^ YJPageViewDidSelectBlock)(YJPageViewController *pageVC);


/** page view*/
@interface YJPageView : UIView

@property (nonatomic) BOOL isLoop;           ///< 是否循环展示、默认NO不循环
@property (nonatomic) BOOL isDisableScrool;  ///< 是否取消用户手势滚动
@property (nonatomic) BOOL isDisableBounces; ///< 是否取消阻力效果（YES时，isLoop自动设为NO）
@property (nonatomic) NSTimeInterval timeInterval; ///< 轮播转动时间间隔（0停止；>0时开启，自动设置isLoop=YES,isDisableBounces=NO）
@property (nonatomic) BOOL isTimeLoopAnimatedStop; ///< 轮播时，是否动画切换（默认NO，开启动画切换）
@property (nonatomic, copy) YJPageViewAppearBlock pageViewAppear;       ///< YJPageViewController显示通知
@property (nonatomic, copy) YJPageViewDidSelectBlock pageViewDidSelect; ///< YJPageViewController点击通知
@property (nonatomic, strong) NSMutableArray<YJPageViewObject *> *dataSource; ///< 数据源
@property (nonatomic, strong, readonly) UIPageViewController *pageVC; ///< 显示的UIPageViewController
@property (nonatomic, strong, readonly) UIPageControl *pageControl;   ///< 。。。提示

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

/**
 *  前往指定界面
 *
 *  @param pageIndex  页码[0...]
 *  @param animated   是否动画
 *  @param completion 回调
 *
 *  @return void
 */
- (void)gotoPageWithIndex:(NSInteger)pageIndex animated:(BOOL)animated completion:(void (^ __nullable)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
