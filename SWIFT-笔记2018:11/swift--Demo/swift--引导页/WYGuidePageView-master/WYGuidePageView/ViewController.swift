//
//  ViewController.swift
//  WYGuidePageView
//
//  Created by 薇谙 on 2018/7/10.
//  Copyright © 2018年 WY. All rights reserved.
//

import UIKit
// import WYGuidePageView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 首页背景图
        let imageView = UIImageView.init(image: UIImage.init(named: "view_bg_image.png"))
        imageView.frame = self.view.bounds
        self.view.addSubview(imageView)
        
        let imageGifArray = ["guideImage5.jpg","adImage4.gif","guideImage7.gif","guideImage3.jpg", "shopping.gif"]
        let guideView = WYGuidePageView.init(images: imageGifArray, loginRegistCompletion: {
            print("登录/注册")
        }) {
            print("开始使用app")
        }
        self.view.addSubview(guideView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

