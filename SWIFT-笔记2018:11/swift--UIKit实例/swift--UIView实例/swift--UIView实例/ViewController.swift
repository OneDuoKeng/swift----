//
//  ViewController.swift
//  swift--UIView实例
//
//  Created by 研发ios工程师 on 2018/11/8.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let view1 = UIView()
        let view2 = UIView(frame:CGRect(x: 20, y: 120, width: 100, height: 100))
        let view3 = UIView(frame:CGRect(x: 40, y: 140, width: 100, height: 100))
        
         view1.frame = CGRect(x: 10, y: 100, width: 100, height: 100)
        
        //设置view的背景色
        view1.backgroundColor = UIColor.red
        view2.backgroundColor = UIColor.green
        view3.backgroundColor = UIColor.blue
        
        //设置view的中心位置,不改变view的大小
        view1.center = CGPoint(x: 80.0, y: 200.0)
        
        //改变view的宽和高,视图原来的中心位置不变
        view1.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        //设置view的tag值
        view1.tag = 1;
        view2.tag = 2;
        view3.tag = 3;
        
        //依次添加三个视图(从上到下是:蓝,绿,红)
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        self.view.addSubview(view3)
        
        //把view1(红)移到最上面
        self.view.bringSubviewToFront(view1)
        
        //把view3(蓝)移到最下面
        self.view.sendSubviewToBack(view3)
        
        //交换两个视图的位置
        self.view.exchangeSubview(at: 0, withSubviewAt: 2)
        
        //把一个视图插在某个位置
        self.view.insertSubview(view1, at:2)
        
        //把一个视图插在另一个视图的下面
        self.view.insertSubview(view1, belowSubview: view3)
        
        //把一个视图插在另一个视图的上面
        self.view.insertSubview(view1, aboveSubview: view2)
        
        //已经添加了某个视图
        self.view.didAddSubview(view1)
        
        //将要移除某个视图
        self.view.willRemoveSubview(view1)
        
        //把一个视图从一个父视图上移到另一个父视图上
        self.view.willMove(toSuperview: view3)
        
        //已经移动到了父视图上
        self.view.didMoveToSuperview()
        
        //把一个视图移动到一个窗口上
        self.view.willMove(toWindow: UIApplication.shared.keyWindow)
        
        //已经移动到了一个窗口上
        self.view.didMoveToWindow()
        
        //subViews中存放的(红,绿,蓝三个视图)
        let subViews :NSArray = NSArray.init(array:self.view.subviews)
        
        //如何找到一个视图,其实此时view4就是view1,view5也是view1
        let view4 = subViews.object(at: 0)as!UIView
        view4.backgroundColor = UIColor.black
        let view5 = self.view.viewWithTag(1)
        view5?.backgroundColor = UIColor.purple
        
        //隐藏view1
        view1.isHidden = true;
        
        //删除View2
        view2.removeFromSuperview()
        
        //再添加一个视图
        let lastView = UIView()
        lastView.frame = CGRect(x: 0, y: 200, width: 200, height: 200)
        lastView.backgroundColor = UIColor.init(white:0.80, alpha: 1)
        self.view.addSubview(lastView)
        
        //设置view的透明度
        lastView.alpha = 0.5
        //设置lastView的圆角角度
        lastView.layer.cornerRadius = 10
        //设置边框的的宽度
        lastView.layer.borderWidth = 2
        //设置边框的颜色
        lastView.layer.borderColor = UIColor.red.cgColor
        //允许剪切
        lastView.clipsToBounds = true
        
        let lastViewClick = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        lastView.addGestureRecognizer(lastViewClick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        lastView.isUserInteractionEnabled = true
        
        //MARK:图片作为背景色
        //将导入的图片作为纹理,平铺整个屏幕
        let image = UIImage(named: "startImage")
        
        //新建颜色对象,将导入的图片赋予该对象
        
        let patternColor = UIColor.init(patternImage: image!)
        
        self.view.backgroundColor = patternColor
        
    }
    //点击事件方法
    @objc func singleTap()
    {
        let alertView = UIAlertController(title: "Infomation", message: "Single Tap", preferredStyle: UIAlertController.Style.alert)
        
        let OkAction = UIAlertAction(title: "ok",style: .default, handler: {_ in})
        
        alertView.addAction(OkAction)
        
        self.present(alertView,animated: true,completion: nil)
        
        //点击图片会弹出窗口提示 Single tap
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
}

