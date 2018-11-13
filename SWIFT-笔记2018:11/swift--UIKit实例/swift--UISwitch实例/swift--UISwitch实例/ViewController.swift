//
//  ViewController.swift
//  swift--UISwitch实例
//
//  Created by huMac on 2018/11/11.
//  Copyright © 2018 huMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //定义控件x:30 y:100 width:80 height:40
        let switcher = UISwitch(frame: CGRect(x: 30, y: 100, width: 80, height: 40))
        self.view.addSubview(switcher)
        //设置开启状态显示的颜色
        switcher.onTintColor = UIColor.red
        //设置关闭状态的颜色
        switcher.tintColor = UIColor.green
        //滑块上小圆点的颜色
        switcher.thumbTintColor = UIColor.yellow
        

        //添加状态变化监听器
        switcher.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)
   
        //获取保存的状态值
        let state = UserDefaults.standard.bool(forKey: "switchState")
        switcher.setOn(state, animated: true)
    }

    @objc
    func switchDidChange(_ sender: UISwitch){
        
        //把当前状态保存起来
        UserDefaults.standard.set(sender.isOn, forKey: "switchState")
        //打印当前值
        print(sender.isOn)
    }
}

