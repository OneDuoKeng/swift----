//
//  threeViewController.swift
//  swift--NavigationBar实例
//
//  Created by 研发ios工程师 on 2018/11/13.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

class threeViewController: UIViewController ,UINavigationControllerDelegate, UIGestureRecognizerDelegate{

    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK:  自定义侧滑手势
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.delegate = self

        // self.title = "自定义导航栏啦"
        
        self.view.backgroundColor = UIColor.yellow
        //自定义标题视图
        
        //        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        
        //        titleLabel.textAlignment = NSTextAlignment.Center
        
        //        titleLabel.backgroundColor = UIColor.grayColor()
        
        //        titleLabel.font = UIFont.boldSystemFontOfSize(25)
        
        //        titleLabel.textColor = UIColor.redColor()
        
        //        titleLabel.text = "hehe"
        
        //        self.navigationItem.titleView = titleLabel
        
        let button = UIButton(type: UIButton.ButtonType.system)
        
        button.setTitle("自定义导航栏啦", for: UIControl.State.normal)
        
        button.addTarget(self, action: #selector(titleViewBtnClick(btn:)), for: UIControl.Event.touchUpInside)
        
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        
        self.navigationItem.titleView = button
        
        
        //MARK:-----------UINavigationItem两侧按钮-----------
        //MARK:  自定义之后侧滑失效
        //第一种方式
        
        let leftItem1 = UIBarButtonItem(title: "anniu", style: UIBarButtonItem.Style.done, target: self, action:#selector(leftAnniuClick))
        //        self.navigationItem.leftBarButtonItem = leftItem1
        
        //第一种方式
        
        let leftItem2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.bookmarks, target: self, action: #selector(btnClick(btn:)))
        
        //        self.navigationItem.leftBarButtonItem = leftItem2
        
        self.navigationItem.leftBarButtonItems = [leftItem1, leftItem2]
        
        //第三种方式（自定义按钮）
        
        let rightButton = UIButton(type: UIButton.ButtonType.custom)
        
        rightButton.frame = CGRect(x: 0, y: 0, width: 33, height: 32)
        
        rightButton.addTarget(self, action: #selector(rightBtnClick(btn:)), for: UIControl.Event.touchUpInside)
        
        rightButton.setImage(UIImage(named: "add_normal"), for: UIControl.State.normal)
        
        let rightItem = UIBarButtonItem(customView: rightButton)
        
        self.navigationItem.rightBarButtonItem = rightItem
        
        //MARK:--------------UINavigationBar导航栏背景设置-----------
        
        //隐藏导航栏
        //self.navigationController?.navigationBarHidden = true
        
        //设置导航栏背景风格
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        
        //设置导航栏的半透明效果，默认是yes
        
        //        self.navigationController?.navigationBar.translucent = false
        
        //设置导航栏的背景颜色(必须有半透明效果)
        
        //        self.navigationController?.navigationBar.backgroundColor = UIColor.redColor()
        
        //将导航上所有的Label的字体变色
        
        self.navigationController?.navigationBar.tintColor = UIColor.red
        
        //设置图片作为导航栏的背景,设置了背景图片，导航栏就不透明
        
        var img = UIImage(named: "")
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: 64))
        
        img?.draw(in: CGRect(x: 0, y: 0, width: width, height: 64))
        
        img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        
        
        
        //设置提示文本,通常用不上
        
        //        self.navigationItem.prompt = "正在保存";
        

    }
    @objc  func titleViewBtnClick(btn: UIButton) {
        
        print("标题被点击了")
        
    }
    
    
    
    @objc func leftAnniuClick() {
        
        print("anniu被点击了")
         self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    @objc func btnClick(btn: UIButton) {
        
        print(btn)
    }

    @objc func rightBtnClick(btn: UIButton) {
        
        print("rightBtnClick")
        
    }
    


}
