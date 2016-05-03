//
//  YJPageViewObject.m
//  YJPageView
//
//  Created by admin on 16/5/3.
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
