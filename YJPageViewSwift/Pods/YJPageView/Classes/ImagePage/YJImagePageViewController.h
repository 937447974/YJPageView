//
//  YJImagePageViewController.h
//  YJPageView
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//  HomePage:https://github.com/937447974/YJPageView
//
//  Created by 阳君 on 16/5/7.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJImagePageModel.h"

/** UIImageView样式*/
@interface YJImagePageViewController : YJPageViewController

// 可通过imageView.topSpaceToSuper(0).bottomSpaceToSuper(0).leadingSpaceToSuper(0).trailingSpaceToSuper(0)修改位置
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
