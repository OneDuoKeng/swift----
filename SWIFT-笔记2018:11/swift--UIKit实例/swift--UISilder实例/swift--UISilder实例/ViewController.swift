//
//  ViewController.swift
//  swift--UISilder实例
//
//  Created by 研发ios工程师 on 2018/11/12.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var slider = UISlider()//初始化
    override func viewDidLoad() {
        super.viewDidLoad()

        slider.frame = CGRect(x:10, y:240, width:self.view.bounds.size.width - 20, height:150)
        
        slider.minimumValue = 0 //最小值
        slider.maximumValue = 1 //最大值
        slider.value = 0.5 //默认值
        self.view.addSubview(slider)
        
        slider.setValue(0.8,animated:true)
        
        slider.isContinuous = false//滑块滑动停止后才触发ValueChanged事件
        
        slider.addTarget(self, action: #selector(sliderDidchange(seliderValue:)), for: .valueChanged)
        
        slider.minimumTrackTintColor=UIColor.red  //左边槽的颜色
        slider.maximumTrackTintColor=UIColor.green //右边槽的颜色
        
//        slider.minimumValueImage=UIImage(named:"11.jpg")  //左边图标
//        slider.maximumValueImage=UIImage(named:"hgl.jpeg")  //右边图标
        //设置滑块右边部分的图片
//        slider.setMaximumTrackImage(UIImage(named: "11.jpg"), for: .normal)
        //滑块左边部分的图片
//        slider.setMinimumTrackImage(UIImage(named: "hgl.jpeg"), for: .normal)
//
        //设置滑块的图片
//        slider.setThumbImage(UIImage(named: "hgl.jpeg"), forState: UIControl.State.normal)
        
        //设置滑块右边部分的图片-使用三宫格缩放（左右14像素不变，中间缩放）
//        let imgTrackRight = UIImage(named: "hgl.jpeg")
//        let imgRight = imgTrackRight?.stretchableImage(withLeftCapWidth: 0, topCapHeight: 10)
//        slider.setMaximumTrackImage(imgRight, for: .normal)
    }
    
    @objc func sliderDidchange(seliderValue:UISlider) {
        
        print(slider.value)
        
    }
}

