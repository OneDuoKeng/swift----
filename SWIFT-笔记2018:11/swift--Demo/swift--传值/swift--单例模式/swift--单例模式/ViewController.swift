//
//  ViewController.swift
//  swift--单例模式
//
//  Created by 研发ios工程师 on 2018/11/13.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //        创建两个常量，用来表示同一个单例类的实例
        let singleton1 = Singleton.singleton
        let singleton2 = Singleton.singleton
        
        //        观察输出结果
        singleton1.doSomething()
        //        更该第二个单例对象的属性值
        singleton2.action = "Walk"
        singleton2.doSomething()
        singleton1.doSomething()

    }
}

