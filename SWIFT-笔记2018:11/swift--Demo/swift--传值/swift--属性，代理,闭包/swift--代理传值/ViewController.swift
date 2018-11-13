//
//  ViewController.swift
//  swift--代理传值
//
//  Created by 研发ios工程师 on 2018/11/13.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

//MARK:代理步骤
//代理的六大步骤
//
//1.后页面制定协议
//
//2.前页面代理遵循协议
//
//3.后页面设置代理属性
//
//4.前页面指定代理self
//
//5.后页面发送代理方法命令
//
//6.前页面代理实现代理方法
//

import UIKit

// 遵循协议
class ViewController: UIViewController,SecondVCDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "代理传值"
        // 创建一个button
        let button1 = UIButton(frame: CGRect(x: 120, y: 120, width: 50, height: 50))
        // 修改背景颜色
        button1.backgroundColor = UIColor.red
        self.view.addSubview(button1)
        // 点击方法
        button1.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControl.Event.touchUpInside)
    }
   
    // button点击方法
    @objc func buttonAction(sender:UIButton){
        
        // 跳转下一个界面
        let secondVC = SecondViewController()
        // 属性传值
        secondVC.passValue = "咻"
        // 指定代理
         secondVC.delegate = self
        // 定义block
//        secondVC.block = { (tempColor:UIColor)->Void in
//            self.view.backgroundColor = tempColor
//        }
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    // 实现代理方法
    func changeColor(tempColor: UIColor) {
        
        self.view.backgroundColor = tempColor
    }
}

