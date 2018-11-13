//
//  ViewController.swift
//  swift--UITa实例pGestureRecognizer
//
//  Created by huMac on 2018/11/12.
//  Copyright © 2018 huMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

        let img = UIImage(named: "发现Sele")
        let imgView = UIImageView(frame: CGRect(x: 40, y: 50, width: 200, height: 200))
        imgView.image = img
        //开启图像视图的交互功能
        imgView.isUserInteractionEnabled = true
        self.view.addSubview(imgView)
        
        //创建一个手势监测类
        let guesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.singleTap))
        
        imgView.addGestureRecognizer(guesture)
    }
    
    @objc func singleTap()
    {
        //弹出提示窗口
        let alertController = UIAlertController(title: "单击手势", message: "点我", preferredStyle: UIAlertController.Style.alert)
        //设置一个按钮关闭提示窗口
        let OKAction = UIAlertAction(title: "确定", style: UIAlertAction.Style.default) {_ in
        }
        //把按钮添加到窗口
        alertController.addAction(OKAction)
        //把提示窗口添加到当前视图控制器
        self.present(alertController, animated: true, completion: nil)

    }
}

