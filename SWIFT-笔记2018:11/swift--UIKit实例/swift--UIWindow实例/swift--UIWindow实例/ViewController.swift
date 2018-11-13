//
//  ViewController.swift
//  swift--UIWindow实例
//
//  Created by 研发ios工程师 on 2018/11/13.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mview = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        //获取delegate
        let delegate = UIApplication.shared.delegate as! AppDelegate
        mview.backgroundColor = UIColor(red: 225.0, green: 110.0, blue: 4.0, alpha: 0.8)
        //添加tag
        mview.tag = 1
        //添加视图
        delegate.window?.addSubview(mview)
//        //通过tag 从window移除视图
//        delegate.window?.viewWithTag(1)?.removeFromSuperview()
    }
}

