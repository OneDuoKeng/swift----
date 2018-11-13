//
//  ViewController.swift
//  swift--UIButton实例
//
//  Created by 研发ios工程师 on 2018/11/7.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//
// MARK: - 关键词 class override
/*
 class 关键字:
 在方法(func 关键字)前 写class关键字有两个作用:
 1.在父类中声明这个方法是类方法, 使用类名调用, 本类和子类的类名都可以调用.
 2.这个类方法可以被子类重写, 重写后的方法使用子类的实例对象调用.
 override 关键字:
 1.在子类中重写父类的实例方法, 使用子类的实例对象调用.
 class关键字是写在父类中的, 声明这个方法是类方法, 并且可以被子类重写.
 override关键字是写在子类中的, 声明这个方法是重写父类的方法.
 */

import UIKit
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

class ViewController: UIViewController {

    let centerX = CGFloat(UIScreen.main.bounds.width/2) //全局变量
//    let btn2:UIButton = UIButton(type: .system) //创建一个全局的按钮
//    MARK:懒加载btn2 lazy var 名字：类型 = 类创建
    private lazy var  btn2:UIButton = UIButton(type: .system)
    private lazy var  btn4:HJButton = HJButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化创建一个 局部的btn
        let btn1:UIButton = UIButton(frame: CGRect(x: centerX - 60, y: 100, width: 120, height: 60))
        //设置背景色
        btn1.backgroundColor = UIColor.orange
        //设置按钮文字
        btn1.setTitle("局部按钮", for: UIControl.State.normal)
        //btn1.setTitle("点我", for: .normal)
        //设置字体大小
        btn1.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        //添加点击事件
        btn1.addTarget(self, action: #selector(btn1Action), for: .touchUpInside)
        // 设置按钮不同状态下的图片
        btn1.setImage(UIImage(named: "add_normal") , for: UIControl.State.normal)
        btn1.setImage(UIImage(named: "add_select"), for: UIControl.State.selected)
        
        // 按钮内容的边距（顶部、左边、底部、右边
        btn1.contentEdgeInsets = UIEdgeInsets(top: 40, left: 0, bottom: 30, right: 0)
        // 按钮上图片的边距
        btn1.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        // 按钮上文本框的边距
        btn1.titleEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)

        //添加到view
        self.view.addSubview(btn1)
        //在方法里创建btn2
        setUpBtn2()
        
        // MARK: - 运用分类创建button
        let btn3:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 170, height: 70))
        btn3.center = CGPoint(x: centerX, y: 400)
        btn3.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14) //文字大小
        btn3.setTitleColor(UIColor.orange, for: UIControl.State.normal) //文字颜色
        btn3.set(image: UIImage(named: "add_normal"), title: "文字在下", titlePosition: .bottom,
                 additionalSpacing: 10.0, state: .normal)
        view.addSubview(btn3)
        
        // MARK: - 运用继承子类HJButton类创建button
        let btn4:HJButton = HJButton(frame: CGRect(x: 0, y: 0, width: 170, height: 70))
        btn4.center = CGPoint(x: centerX, y: 500)
        btn4.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14) //文字大小
        btn4.setTitleColor(UIColor.blue, for: UIControl.State.normal) //文字颜色
        btn4.set(image: UIImage(named: "add_normal"), title: "文字在右", titlePosition: .right,
                 additionalSpacing: 10.0, state: .normal)
        view.addSubview(btn4)
    }
    
    // MARK: - 方法里创建btn2
    func setUpBtn2()  {
        btn2.frame = CGRect(x: centerX - 60, y: 200, width: 120, height: 60)
        btn2.setTitle("全局按钮", for: .normal)
        btn2.backgroundColor = UIColor.cyan
        btn2.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        //高亮状态highlighted
        btn2.setTitleColor(UIColor.red, for: UIControl.State.highlighted)
        //设置能否点击 true 和 false
        btn2.isEnabled = true
        
        //btn2.imageView?.image = UIImage.init(named: "add_select")
        btn2.addTarget(self, action: #selector(btn2Action(button:)), for: .touchUpInside)
        self.view.addSubview(btn2)
    }
    
    // MARK: - btn1的点击事件
    @objc func btn1Action() {
        print("1创建成功！！")
    }
    
    // MARK: - 带参数按钮点击方法
    /// - Parameter _button: 按钮对象  参数写在前面  类名写在后面 与oc反过来了
    @objc func btn2Action(button:UIButton) {
        print("2创建成功！！")
        print(String.init(format: "2创建成功！：%@", button))
        //反选效果
        button.isSelected = !button.isSelected;
        
        //获取按钮当前文字
        print(button.currentTitle!)
        
        /*
         按钮当前的一些属性，注意：只能读取，不能修改
         currentTitle//当前文字
         currentTitleColor//当前文字颜色
         currentTitleShadowColor//当前文字阴影色
         currentImage//当前图片
         currentBackgroundImage//当前背景图片
         */
    }
    
    
    @objc func buttonClick(button:UIButton ){
        button.isSelected = !button.isSelected
        if button.isSelected {
            button.setTitle("Selected", for: .normal)
        }else{
            button.setTitle("NoSelected", for: .normal)
        }
    }
    
    //TODO: ----这是要做的是的标记-------
    //FIXME:----需要修改的bug-----
    
    
    /*
     convenience : 便利，使用convenience修饰的构造函数叫做便利构造函数
     便利构造函数通常在对系统的类进行构造函数的扩充时使用
     便利构造函数的特点
     1.便利构造函数通常是写在extension中
     2.便利构造函数init前面需要加载convenience
     3.在便利构造函数中需要明确调用self.init
     */
    /*
     convenience init(imageName : String , bgImageName : String) {
     self.init()
     //设置按钮的图片
     setImage(UIImage(named: imageName), for: UIControlState.normal)
     setImage(UIImage(named: imageName + "_highlighted"), for: UIControlState.highlighted)
     //设置按钮的背景图片
     setBackgroundImage(UIImage(named: bgImageName), for: UIControlState.normal)
     setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: UIControlState.highlighted)
     
     //按照背景图片初始化按钮尺寸
     sizeToFit()
     
     }
     
     */
    /*
     //这里的类方法相当于OC中的加号方法
     class func creatButtonWithImageName(imageName : String , bgImageName : String) -> UIButton {
     
     //创建按钮
     let button = UIButton()
     
     //设置按钮的背景图片
     button.setBackgroundImage(UIImage(named: bgImageName), for: UIControlState.normal)
     button.setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: UIControlState.highlighted)
     
     //设置按钮的图片
     button.setImage(UIImage(named: imageName), for: UIControlState.normal)
     button.setImage(UIImage(named: imageName + "_highlighted"), for: UIControlState.highlighted)
     
     //按照背景图片初始化按钮尺寸
     button.sizeToFit()
     
     //返回按钮
     return button
     }

     */
}

