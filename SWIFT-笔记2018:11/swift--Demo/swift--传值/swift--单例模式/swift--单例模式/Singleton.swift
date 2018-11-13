//
//  Singleton.swift
//  swift--单例模式
//
//  Created by 研发ios工程师 on 2018/11/13.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import Foundation
//创建一个单例类
//如果一个类始终只能创建一个实例，则这个类被称为单例类
class Singleton{
    //    给类添加一个属性
    var action = "Run"
    //    对于单例实例来说，需要创建一个唯一对外输出实例的方法
    //    静态变量用static来处理
    static let singleton = Singleton()
    //    创建一个方法，输出实例自身的属性
    func doSomething() {
        print(action)
    }
}

