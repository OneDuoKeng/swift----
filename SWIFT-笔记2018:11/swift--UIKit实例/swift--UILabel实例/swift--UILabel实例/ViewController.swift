//
//  ViewController.swift
//  swift-UIlabel实例
//
//  Created by 研发ios工程师 on 2018/11/7.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var label = UILabel()
    let btn = UIButton()
    var isSeclet = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setLabel()
        setBtn()
        //MARK: 快速创建label
        let hjlabel = HJLabel.creatLable(cg: CGRect(x:50, y:400, width:200, height:100), font: 14, textAlignment: NSTextAlignment.left, textColor: UIColor.black, text: "快速创建label")
        self.view.addSubview(hjlabel)
    }

    func setLabel() {
        //初始化UILabel
        label=UILabel()
        //label大小
        label.frame = CGRect(x:50, y:100, width:200, height:100)
        label.text = "Hello Swift"
        //背影色
        label.backgroundColor=UIColor.lightGray
        //灰色阴影
        label.shadowColor = UIColor.gray
        //阴影的偏移量
        label.shadowOffset = CGSize(width:1.5, height:1.5)
        //对齐方式的设置
        label.textAlignment=NSTextAlignment.center
        //字体
        label.font=UIFont(name:"Thonburi",size:30)
        //Gray
        var labColor=UIColor(white:1,alpha:1);
        //RGB
        labColor=UIColor(red:255,green:255,blue:0,alpha:1)
        //系统色
        labColor=UIColor.lightText
        //静态色
        labColor=UIColor.red;
        label.textColor=labColor
        //文字过长时的省略方式
        //label.lineBreakMode = .byTruncatingMiddle //隐藏中间部分并显示省略号
        //当文字超出标签宽度时，自动调整文字大小，使其不被截断
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2 //显示两行文字
        self.view.addSubview(label)
    }
    
    @objc func setAttributeString() {
        var level:String?
        isSeclet = !isSeclet
        level = isSeclet ? "来来来来来来" : " 去去去去去去"
        let attributeString = NSMutableAttributedString(string:level!)
        //从文本0开始6个字符字体HelveticaNeue-Bold,13号
        attributeString.addAttribute(NSAttributedString.Key.font,  value: UIFont(name: "HelveticaNeue-Bold", size: 13)!, range: NSMakeRange(0,5))
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue,range: NSMakeRange(0, 3))
        attributeString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.green,range: NSMakeRange(3,3))
        label.attributedText = attributeString
    }
    
    func setBtn() {
        btn.frame = CGRect(x:50, y:300, width:150, height:50)
        btn.setTitle("来点我", for: .normal)
        btn.backgroundColor = UIColor.green
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(setAttributeString), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn)
    }
}

