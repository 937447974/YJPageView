//
//  YJPageViewController.h
//  YJPageView
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJPageViewObject, YJPageView;

/** PageView的item基类*/
@interface YJPageViewController : UIViewController

@property (nonatomic, weak) YJPageViewObject *pageViewObject; ///< 封装的模型
@property (nonatomic, weak) YJPageView *pageView; ///< YJPageView 

/**
 *  根据模型刷新page
 *
 *  @param pageViewObject page封装的对象
 *  @param pageView       YJPageView
 *
 *  @return void
 */
- (void)reloadPageWithPageViewObject:(YJPageViewObject *)pageViewObject pageView:(YJPageView *)pageView;

@end
