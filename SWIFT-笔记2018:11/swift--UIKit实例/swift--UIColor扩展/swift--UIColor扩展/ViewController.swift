//
//  ViewController.swift
//  swift--UIColor扩展
//
//  Created by 研发ios工程师 on 2018/11/13.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        // 1.调用类方法
        self.view.backgroundColor = UIColor.getRandomColor()
        
//        // 2.调用构造方法
//        self.view.backgroundColor = UIColor(r: 234, g: 134, b: 123)
//        
//        // 3.直接传入美工给的16进制颜色字符串
//        self.view.backgroundColor = UIColor(hexString: "#cc0033")
//        
  
    }


}

