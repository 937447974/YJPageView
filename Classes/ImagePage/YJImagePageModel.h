//
//  YJImagePageModel.h
//  YJPageView
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//  HomePage:https://github.com/937447974/YJPageView
//
//  Created by 阳君 on 16/5/7.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/** YJImagePageViewController对应的model*/
@interface YJImagePageModel : NSObject

@property (nonatomic) BOOL isOnClick;            ///< 能否点击
@property (nonatomic, copy) NSString *imagePath; ///< 图片地址

@end
