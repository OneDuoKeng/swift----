//
//  ViewController.swift
//  swift--UIProgressView实例
//
//  Created by 研发ios工程师 on 2018/11/9.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       createProcessView ()
    }
    
    //UIProcessView 进度条
    func createProcessView (){
        
        //创建进度条
        let progressView = UIProgressView()
        
        //设置进度条的尺寸
        progressView.frame =  CGRect(x: 20, y: 300, width: 280, height: 30)
       
        //设置进度条的风格
        progressView.progressViewStyle = UIProgressView.Style.bar
        progressView.progressViewStyle = UIProgressView.Style.default
        
        //进度条当前的进度
        progressView.progress = 0.5
        
        //进度条走过的颜色
        progressView.progressTintColor = UIColor.red
        
        //进度条轨道的颜色
        progressView.trackTintColor = UIColor.blue
        
        //进度条前进的的图片
//        progressView.progressImage = UIImage(named:"icon1")
        
        //进度条轨道的图片
//        progressView.trackImage = UIImage(named:"icon2")
        
        //设置当前进度
        progressView.setProgress(0.8, animated:true)
        
        //添加进度条
        self.view.addSubview(progressView)
        
    }
}

