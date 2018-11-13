//
//  SecondViewController.swift
//  swift--代理传值
//
//  Created by 研发ios工程师 on 2018/11/13.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

protocol SecondVCDelegate {
    
    // 协议中的方法
    
    func changeColor(tempColor:UIColor)
    
}

class SecondViewController: UIViewController {

    // 属性
    
    var passValue:String?
    
    // 代理属性
    
    var delegate:SecondVCDelegate?
    
    // block属性
    // var block:((UIColor)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.cyan
        self.title = "第二个页面"
        // 返回button
        let button2 = UIButton(frame: CGRect(x: 120, y: 120, width: 50, height: 50))
        button2.backgroundColor = UIColor.black
        button2.addTarget(self, action: #selector(button2Action(sender:)) , for: UIControl.Event.touchUpInside)
        self.view.addSubview(button2)
    }

    // button2点击方法
    @objc func button2Action(sender:UIButton) {
        // 发送代理方法命令
        self.delegate?.changeColor(tempColor: UIColor.blue)
        // 调用block
        //self.block!(UIColor.red)
        // 返回
        self.navigationController?.popViewController(animated: true)
    }
}
