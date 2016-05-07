//
//  YJImagePageViewController.m
//  YJPageView
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//  HomePage:https://github.com/937447974/YJPageView
//
//  Created by 阳君 on 16/5/7.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJImagePageViewController.h"
#import "YJImagePageModel.h"

@interface YJImagePageViewController () {
    UIImageView *_imageView;
}

@end

@implementation YJImagePageViewController

#pragma mark - YJPageView
- (void)reloadPageWithPageViewObject:(YJPageViewObject *)pageViewObject pageView:(YJPageView *)pageView {
    
    [super reloadPageWithPageViewObject:pageViewObject pageView:pageView];
    YJImagePageModel *model = pageViewObject.pageModel;
    self.imageView.image = [UIImage imageNamed:model.imagePath];
    if (model.isOnClick && !self.imageView.userInteractionEnabled) {
        self.imageView.userInteractionEnabled = YES;
        [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImageView)]];
    }
    
}

#pragma mark 点击图片
- (void)onClickImageView {
    self.pageView.pageViewDidSelect(self);
}

#pragma mark - getter and setter
- (UIImageView *)imageView {
    if (_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_imageView];
        _imageView.topSpaceToSuper(0).bottomSpaceToSuper(0).leadingSpaceToSuper(0).trailingSpaceToSuper(0);
    }
    return _imageView;
}


@end
