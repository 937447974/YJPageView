//
//  YJPageView.h
//  YJPageView
//
//  Created by admin on 16/4/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** page view*/
@interface YJPageView : UIView

@property (nonatomic, strong, readonly) UIPageViewController *pageVC; ///< 显示的UIPageViewController

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

@end

NS_ASSUME_NONNULL_END
