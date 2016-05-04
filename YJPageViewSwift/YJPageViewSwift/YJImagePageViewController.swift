//
//  YJImagePageViewController.swift
//  YJPageViewSwift
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 YJ. All rights reserved.
//

import UIKit

class YJImagePageViewController: YJPageViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func reloadPageWithPageViewObject(pageViewObject: YJPageViewObject, pageView: YJPageView) {
        super.reloadPageWithPageViewObject(pageViewObject, pageView: pageView)
        self.imageView.image = UIImage(named: "LaunchImage")
    }

}