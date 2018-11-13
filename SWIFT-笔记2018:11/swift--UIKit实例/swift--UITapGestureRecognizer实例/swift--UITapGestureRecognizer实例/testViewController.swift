//
//  testViewController.swift
//  swift--UITapGestureRecognizer实例
//
//  Created by huMac on 2018/11/12.
//  Copyright © 2018 huMac. All rights reserved.
//

import UIKit

class testViewController: UIViewController {

    let view1 = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view1.backgroundColor = UIColor.green
        self.view.addSubview(view1)
        
        //向上滑动
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
        upSwipe.direction = .up;
        self.view.addGestureRecognizer(upSwipe)
        //向下滑动
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
        downSwipe.direction = .down;
        self.view.addGestureRecognizer(downSwipe)
        
        //边缘滑动
        let edgeSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgeSwipe(_:)))
        edgeSwipe.edges = .left
        self.view.addGestureRecognizer(edgeSwipe)
        
        //单点手势
        let tapSingle = UITapGestureRecognizer(target: self, action: #selector(tapSingleClick))
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tapSingle)
        
        //双击手势
        let tapDouble = UITapGestureRecognizer(target: self, action: #selector(tapDoubleClick))
        tapDouble.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(tapDouble)
        
        //捏合手势
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pichClick(_:)))
        self.view.addGestureRecognizer(pinch)
        
        //旋转手势
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(rotationClick(_:)))
        self.view.addGestureRecognizer(rotation)
      
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panClick(_:)))
        view1.addGestureRecognizer(pan)
        
        //长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressClick(_:)))
        longPress.minimumPressDuration = 2//长按启动时间设置
        self.view.addGestureRecognizer(longPress)
    }
    
    //上下滑动
    @objc func swipe(_ recongizer:UISwipeGestureRecognizer){
        let point = recongizer.location(in: self.view)
        if recongizer.direction == .up{
            print("向上滑动point = \(point)")
        }else if recongizer.direction == .down{
            print("向下滑动point = \(point)")
        }
    }
    
    //边缘滑动
    @objc func edgeSwipe(_ recongizer:UIScreenEdgePanGestureRecognizer){
        let point = recongizer.location(in: self.view)
        print("边缘滑动point = \(point)")
    }
    
    //单击
    @objc func tapSingleClick(){
        print("单击了")
    }
    //双击
    @objc func tapDoubleClick(){
        print("双击了")
    }
    //捏合
    @objc func pichClick(_ recongnizer:UIPinchGestureRecognizer){
        print(recongnizer.scale)
        print(recongnizer.location(in: self.view))
    }
    //旋转
    @objc func rotationClick(_ recongnizer:UIRotationGestureRecognizer){
        //旋转的弧度装换为角度
        print(recongnizer.rotation*(180/CGFloat.pi))
    }
    //拖动手势
    @objc func panClick(_ recongizer:UIPanGestureRecognizer){
        let point = recongizer.location(in: self.view)
        view1.center = point
    }
    //长按手势
    @objc func longPressClick(_ recongnizer:UILongPressGestureRecognizer){
        if recongnizer.state == .began {
            print("开始点击")
        }else{
            print("结束点击")
        }
    }

}
