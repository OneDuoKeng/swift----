//
//  ViewController.swift
//  Swift进阶知识02
//
//  Created by rookie on 2018/3/5.
//  Copyright © 2018年 zxh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        thirdDemo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*-----------------------------知识点分割线-----------------------------------*/
    // MARK: - swift进阶知识02
    /*
     这一节的知识,虽然代码少,但是除此接触下来有点难以理解,特别摘抄出来,单独写
     这一节,除了要敲代码,还要想一想.这一节是比较理论性的东西
     */
    
    /*-----------------------------知识点分割线-----------------------------------*/
    // MARK: - 重载
    //此项目工程中的 Person 类 和 Student 类,也是该知识点
    //重载的知识点写在person类里面了.此处只验证性调用
    func firstDemo() {
        let p = Person()
        
        //如果Student类里面,没有重写init函数,那么在这里将不能用 Student() 方法 实例化对象
        let s = Student(age: 2)
    }
    
    /*-----------------------------知识点分割线-----------------------------------*/
    // MARK: - KVC
    //此项目工程中的 Man 类,也是该知识点
    func thirdDemo() {
        let m = Man(dict: ["name" : "小明","age" : 14,"id" : "小明的爸爸"])
        print(m.name,m.age,m.sid)
    }
    
    /*-----------------------------知识点分割线-----------------------------------*/
    // MARK: - 便利的构造函数
    //这个在开发中不常用,具体参考Person类中的解释
    
    /*-----------------------------知识点分割线-----------------------------------*/
    // MARK: - 懒加载
    
    //懒加载:使用的时候一定不为空,只会初始化一次
    lazy var nameLabel = UILabel()
    
    //通过有返回值的闭包来实现懒加载
    lazy var ageLabel: UILabel = {
        let l = UILabel()
        //设置
        l.text = "哈哈哈"
        return l
    }()
    
    /*-----------------------------知识点分割线-----------------------------------*/
    // MARK: - setter and getter
    func fiveDemo() {
        let p = Person()
        
        p.title = "哈哈"
        //可以在set方法里面打断点验证
        
    }
    
 
}

