//
//  ViewController.swift
//  YJPageViewSwift
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//
//  Created by 阳君 on 16/5/4.
//  Copyright © 2016年 YJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化
        let pageView = YJPageView(frame: CGRectZero)
        self.view.addSubview(pageView)
        pageView.boundsLayoutTo(self.view)
        // 监听点击
        pageView.pageViewDidSelect = { (pageVC: YJPageViewController) in
            print("点击：\(pageVC.pageViewObject!.pageIndex)")
        }
        // 填充数据源
        for _ in 0..<5 {
            let obj = YJImagePageViewController.pageViewObject()
            let model = YJImagePageModel()
            model.imageNamed = "LaunchImage"
            obj.pageModel = model
            pageView.dataSource.addObject(obj)
        }
        // 刷新界面
        pageView.reloadPage()
    }

}

