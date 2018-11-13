//
//  ViewController.swift
//  swift--通知
//
//  Created by 研发ios工程师 on 2018/11/13.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1 创建通知中心
        // 2 设置监听方法
        // 3 设置通知的名字
    
    //MARK:    创建通知中心
         NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue:"isTest"), object: nil)
    }
    //MARK:    实现通知监听方法
    @objc func test(nofi : Notification){
        let str = nofi.userInfo!["post"]
        print(String(describing: str!) + "this notifi")
    }

    //MARK:     点击发送通知进行
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("isTest"), object: self, userInfo: ["post":"NewTest"])
    }
    
    //MARK:     最后要记得移除通知
    deinit {
        /// 移除通知
        NotificationCenter.default.removeObserver(self)
    }
}

