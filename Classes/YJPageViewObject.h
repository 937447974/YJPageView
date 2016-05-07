//
//  YJPageViewObject.h
//  YJPageView
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//  HomePage:https://github.com/937447974/YJPageView
//
//  Created by 阳君 on 16/5/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 创建pageView的方式*/
typedef NS_ENUM(NSInteger, YJPageViewCreate) {
    
    YJPageViewCreateDefault, ///< 使用class创建page
    YJPageViewCreateXib      ///< 使用xib创建page
    
};

/** PageView模型协议*/
@protocol YJPageViewModelProtocol <NSObject>

@end

/** pageView对应的模型封装*/
@interface YJPageViewObject : NSObject

@property (nonatomic) id<YJPageViewModelProtocol> pageModel; ///< PageView对应的VM
@property (nonatomic) YJPageViewCreate createPageView;       ///< 创建PageView的方式
@property (nonatomic, strong, nullable) id userInfo;         ///< 携带的数据

@property (nonatomic) NSInteger pageIndex;       ///< 当前页码，无须添加，自动填充
@property (nonatomic, readonly) Class pageClass; ///< PageView对应的类

/**
 *  初始化YJPageViewObject
 *
 *  @param pageClass YJPageViewController对应的类
 *
 *  @return void
 */
- (instancetype)initWithPageClass:(Class)pageClass;

@end

NS_ASSUME_NONNULL_END
