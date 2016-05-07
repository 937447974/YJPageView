//
//  YJPageViewObject.m
//  YJPageView
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//  HomePage:https://github.com/937447974/YJPageView
//
//  Created by 阳君 on 16/5/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJPageViewObject.h"

@implementation YJPageViewObject

- (instancetype)initWithPageClass:(Class)pageClass {
    
    self = [super init];
    if (self) {
        _pageClass = pageClass;
    }
    return self;
    
}

@end
