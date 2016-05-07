#1 YJPageView

YJPageView主要实现对轮播图、导航图、小说翻页等多种翻页模式封装。

##1.1 YJPageView的优点

1. 支持iOS6.0和Swift开发。
2. 多种配置模式适应任何多页面需求。
3. 0.02秒切换VC时，内存释放稳定。

##1.2 YJPageView的缺点

暂无。

##1.3 导入YJPageView

导入YJPageView可使用pod导入，相关命令：

```pod
platform :ios, '6.0'
pod 'YJPageView'
```

或

```pod
platform :ios, '6.0'
pod 'YJPageView', :git => 'https://github.com/937447974/YJPageView.git'
```

#2 实战展示

例子代码如下

```objc
// 初始化
YJPageView *pageView = [[YJPageView alloc] initWithFrame:CGRectZero];
[self.view addSubview:pageView];
pageView.boundsLayoutTo(self.view); 
    
// 启用UIPageControl
pageView.pageControl.widthLayout.equalToConstant(100);
pageView.pageControl.heightLayout.equalToConstant(30);
pageView.pageControl.centerLayoutTo(self.view);
pageView.pageControl.pageIndicatorTintColor = [UIColor blueColor];
    
// 修改UIPageViewController
[pageView initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
pageView.timeInterval = 0.5; 

// 监听
pageView.pageViewAppear = ^(YJPageViewController *pageVC, YJPageViewAppear appear) {
    switch (appear) {
        case YJPageViewAppearWill: {
            NSLog(@"Will：%ld", (long)pageVC.pageViewObject.pageIndex);
            break;
        }
        case YJPageViewAppearDid:
            NSLog(@"Did：%ld", (long)pageVC.pageViewObject.pageIndex);
            break;
    }
};
pageView.pageViewDidSelect = ^(YJPageViewController *pageVC) {
    NSLog(@"点击：%ld", (long)pageVC.pageViewObject.pageIndex);
};
// 填充数据源
for (int i=0; i<5; i++) {
    YJPageViewObject *obj = [YJImagePageViewController pageViewObject];
    YJImagePageModel *model = [[YJImagePageModel alloc] init];
    model.imageNamed = @"LaunchImage";
    model.isOnClick = YES;
    obj.pageModel = model;
    [pageView.dataSource addObject:obj];
}
[pageView reloadPage];
```

可实现业务如下所示。

![](https://raw.githubusercontent.com/937447974/Blog/master/Resources/2016050701.jpg)

![](https://raw.githubusercontent.com/937447974/Blog/master/Resources/2016050702.jpg)

#3 压力测试

填充100个UIViewController、自动轮播速度设置为0.02秒。运行半小时如图所示。

从图中可看出0.02秒释放一个UIViewController；运行10分钟，内存稳定。

![](https://raw.githubusercontent.com/937447974/Blog/master/Resources/2016050703.png)

----------

#<a id="Appendix">Appendix

##Author

姓名：阳君

QQ：937447974

YJ技术支持群：557445088

职位：聚美优品iOS攻城师

如果你觉得这个框架很赞，请点击右上角的Star按钮；如果你对我的框架感兴趣，并想持续获得本人最新的框架源文件，欢迎点击右上角的Fork按钮。

如果你也想来和我们一起在聚美优品(北京)从事iOS研发工作，欢迎投递简历到937447974@qq.com。

##Revision History

| 时间 | 描述 |
| ---- | ---- |
| 2016-05-03 | 项目启动 |
| 2016-05-04 | 0.9 项目上线 |
| 2016-05-05 | 1.0 轮播图实现 |
| 2016-05-06 | 1.0.1 可动态控制滑动效果和阻力效果 |
| 2016-05-07 | 1.1.0 增加UIPageControl显示 |

##Copyright

CSDN：http://blog.csdn.net/y550918116j

GitHub：https://github.com/937447974