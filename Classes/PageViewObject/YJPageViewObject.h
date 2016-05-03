//
//  YJPageViewObject.h
//  YJPageView
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 创建pageView的方式*/
typedef NS_ENUM(NSInteger, YJPageViewCreate) {
    
    YJPageViewCreateDefault, ///< 使用class创建cell
    YJPageViewCreateXib      ///< 使用xib创建cell
    
};

/** PageView模型协议*/
@protocol YJPageViewModelProtocol <NSObject>

@end

/** pageView对应的模型封装*/
@interface YJPageViewObject : NSObject

@property (nonatomic) id<YJPageViewModelProtocol> cellModel; ///< PageView对应的VM
@property (nonatomic) YJPageViewCreate createPageView;       ///< 创建PageView的方式
@property (nonatomic, strong, nullable) id userInfo;         ///< 携带的数据

@property (nonatomic, readonly) Class pageClass; ///< PageView对应的类

- (instancetype)initWithPageClass:(Class)pageClass;

@end

NS_ASSUME_NONNULL_END
