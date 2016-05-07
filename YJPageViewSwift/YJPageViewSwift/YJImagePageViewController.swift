//
//  YJImagePageViewController.swift
//  YJPageViewSwift
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//
//  Created by 阳君 on 16/5/4.
//  Copyright © 2016年 YJ. All rights reserved.
//

import UIKit

class YJImagePageViewController: YJPageViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override class func pageViewObject() -> YJPageViewObject {
        let pvo = super.pageViewObject()
        pvo.createPageView = YJPageViewCreate.Xib
        return pvo
        
    }
    
    override func reloadPageWithPageViewObject(pageViewObject: YJPageViewObject, pageView: YJPageView) {
        super.reloadPageWithPageViewObject(pageViewObject, pageView: pageView)
        self.imageView.image = UIImage(named: "LaunchImage")
    }

}
