//
//  UIButtonExtension.swift
//  swift--UIButton实例
//
//  Created by 研发ios工程师 on 2018/11/7.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//
//  swif 只有扩展一说  相当于 oc 分类+l扩展

import Foundation
import UIKit

/*
 总结：1：给UIButton写分类，新建文件swiftFile，一般为了区分起名字都是名字-Extension，要想调用UI控件需要导入 import UIKit框架，然后给系统的类写分类：extension UIButton {}，提供类方法或是构造函数的方法，把与该控件有关的业务逻辑全封装在分类的内部。2：封装方法：类方法：都是以class开头，class func 函数名（参数）->返回值类型{业务逻辑代码，return 返回值}：例子： class func createButton(imageName:String,backgroundImageName:String) -> UIButton {},其中声明函数的时候，没有参数也加（），返回值只写类型。分类不用private和fileprivate修饰 3：构造函数方法：利用便利构造函数：
 convenience init(_ imageName:String,bgImageName:String)
 convenience为便利构造函数，便利构造函数通常用在对系统的类进行构造函数的扩充时使用
 遍历构造函数的特点
 1.遍历构造函数通常都是写在extension里面
 2.遍历构造函数init前面需要加载convenience
 3.在遍历构造函数中需要明确的调用self.init()
 
 convenience init(_ imageName:String,bgImageName:String) {
 
 //1:必须首先调用self.init()
 self.init()
 
 //2:设置按钮
 let higlingStr = "_highlighted"
 
 //2:设置按钮的bg图片与普通图片
 setImage(UIImage(named:imageName), for: .normal)
 setImage(UIImage(named:imageName + higlingStr), for: .highlighted)
 setBackgroundImage(UIImage(named:bgImageName), for: .normal)
 setBackgroundImage(UIImage(named:bgImageName+higlingStr), for: .highlighted)
 
 //3:设置按钮的尺寸
 sizeToFit()
 
 }
 注意：1：在构造函数中不用写返回值，因为系统默认会返回 2：在类中调用该类的方法可以省去self去调用      3：系统的第一个参数默认为内部参数，从第二个参数开始即为内部参数又为外部参数，要想让参数都变为内部参数，则在参数的前面加_+空格，仿照苹果系统的写法
 
 2：懒加载：1：懒加载时用关键字lazy，用private或是fileprivate来修饰 2：懒加载有两种写法：1：直接初始化 如方法1 2：利用闭包懒加载： fileprivate lazy var composeBtn = {return 业务逻辑+返回值}(); ，苹果建议一般定义变量都使用懒加载 3：在定义变量或是属性的时候，必须给定明确的初始化值或是可选类型，后面去赋值，否则会报错
 1：懒加载发布按钮，提供两种创建对象的方法：1：类方法，用类点语法调用
 
 filePrivate
 其修饰的属性或者方法只能在当前的swift源文件中访问(包括extension,包括不同类之间)
 即在同一个文件中,所有的fileprivate方法属性都是可以访问到的
 fileprivate lazy var composeBtn : UIButton = UIButton.createButton(imageName: "tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
 2：对象方法获得button的实例：
 fileprivate lazy var composeBtn = UIButton("tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
 
 3：代码的书写：1：在定义的类中定义属性时，可以懒加载属性，也可以定义成可选类型或是直接给属性赋值，但是定义属性的时候需要考虑用不用private或是fileprivate修饰  2：在viewDidLoad中抽方法封装调用，封装的方法写在该类的extension扩展中 3：若是extension扩展中涉及某些业务逻辑的处理则写成系统类的分类（类方法或是构造函数方法），工具类，继承
 2：在分类或是类中定义方法的时候，也要考虑用private或是fileprivate修饰，对按钮事件的监听：composeBtn.addTarget(self, action: #selector(MainViewController.composeBtnClic), for: .touchUpInside)
 selector用#selector来包装，按钮点击事件的方法用类去调用该方法，枚举用.+枚举值，其中按钮的点击方法也写在extension的扩展中
 3：封装按钮的点击事件：
 extension MainViewController {
 
 @objc fileprivate func composeBtnClic() {
 
 DLog(message: "hello--word")
 
 }
 
 事件监听本质发送消息.但是发送消息是OC的特性
 将方法包装成@SEL --> 类中查找方法列表 --> 根据@SEL找到imp指针(函数指针) --> 执行函数
 如果swift中将一个函数声明称private,fileprivate那么该函数不会被添加到方法列表中
 如果在private前面加上@objc,那么该方法依然会被添加到方法列表中
 
 */

//private var PERSON_ID_NUMBER_PROPERTY = 0

extension UIButton {

    @objc func set(image anImage: UIImage?, title: String,
                   titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    
    private func positionLabelRespectToImage(title: String, position: UIView.ContentMode,
                                             spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}


