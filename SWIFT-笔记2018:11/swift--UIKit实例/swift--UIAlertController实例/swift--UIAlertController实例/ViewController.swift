//
//  ViewController.swift
//  swift--UIAlertController实例
//
//  Created by 研发ios工程师 on 2018/11/9.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var alertBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func alertAction(_ sender: Any) {
        
        showAlertView3()
    }
    
    @IBAction func alertAction2(_ sender: Any) {
        
        let alertController = UIAlertController(title: "通知", message: "确定还是取消", preferredStyle: UIAlertController.Style.alert) // 这里因为控件都不存在改变的可能，所以一律使用let类型
        
        let alertView1 = UIAlertAction(title: "确定", style: UIAlertAction.Style.default) { (UIAlertAction) -> Void in
            
            print("确定按钮点击事件")
            
        }
        
        let alertView2 = UIAlertAction(title: "取消", style: UIAlertAction.Style.default) { (UIAlertAction) -> Void in
            
            print("取消按钮点击事件")
            
        }
        
        alertController.addAction(alertView1)
        
        alertController.addAction(alertView2)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func showAlertView3()  {
        
        let alertController = UIAlertController(title: "通知", message: "确定还是取消", preferredStyle: UIAlertController.Style.alert) // 这里因为控件都不存在改变的可能，所以一律使用let类型
        
        let alertView1 = UIAlertAction(title: "确定", style: UIAlertAction.Style.default) { (UIAlertAction) -> Void in
            
            print("确定按钮点击事件")
            
        }
        
        let alertView2 = UIAlertAction(title: "取消", style: UIAlertAction.Style.default) { (UIAlertAction) -> Void in
            
            print("取消按钮点击事件")
            
        }
        
        let alertView3 = UIAlertAction(title: "下次吧", style: UIAlertAction.Style.default) { (UIAlertAction) -> Void in
            
            print("下次吧按钮点击事件")
            
        }
        alertController.addAction(alertView1)
        
        alertController.addAction(alertView2)
        
        alertController.addAction(alertView3) // 当添加的UIAlertAction超过两个的时候，会自动变成纵向分布
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func textAlerViewAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: "修改昵称", message: nil, preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField(configurationHandler: { (textField: UITextField!) -> Void in
            textField.placeholder = "请输入昵称"
            // 添加监听代码，监听文本框变化时要做的操作
        
        })
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        let okAction = UIAlertAction(title: "确认", style: UIAlertAction.Style.default , handler: { (action: UIAlertAction!) -> Void in
//            let login = (alertController.textFields?.first)! as UITextField
//            let str = login.text
        })
//        okAction.isEnabled = false
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    

    @IBAction func bottomAlerAction(_ sender: Any) {
        show()
    }
    
    func show() {
        let actionSheet = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        //修改title字体及颜色
        let title = "标题"
        let titleStr = NSMutableAttributedString.init(string: title)
        titleStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: NSRange.init(location: 0, length: title.count))
        titleStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize:20), range: NSRange.init(location: 0, length: title.count))
        actionSheet.setValue(titleStr, forKey: "attributedTitle")
        
        // 修改message字体及颜色
        let message = "此处展示提示消息"
        let messageStr = NSMutableAttributedString.init(string: message)
        messageStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: NSRange.init(location: 0, length: message.count))
        messageStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize:20), range: NSRange.init(location: 0, length: message.count))
        actionSheet.setValue(messageStr, forKey: "attributedMessage")
        
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
        }
        // titleTextAlignment 位置
        // titleTextColor 颜色
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        let action = UIAlertAction.init(title: "投诉", style: .default) { (action) in
            
        }
        
        action.setValue(UIColor.blue, forKey: "titleTextColor")
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(action)
        UIApplication.shared.keyWindow?.rootViewController?.present(actionSheet, animated: true, completion: { })
    }
}

