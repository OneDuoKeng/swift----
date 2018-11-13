//
//  ViewController.swift
//  swift--UITextField实例
//
//  Created by 研发ios工程师 on 2018/11/8.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

//MARK: 遵循代理
class ViewController: UIViewController ,UITextFieldDelegate {

    let textField = UITextField(frame:CGRect(x:100,y:100,width:200,height:30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //MARK: 设置代理
        textField.delegate = self
        //设置边框样式
        textField.borderStyle = .roundedRect;
        self.view .addSubview(textField);
        //修改圆角半径(先设置为true)
        textField.layer.masksToBounds = true;
        //圆角半径
        textField.layer.cornerRadius = 12.0;
        //边框粗细
        textField.layer.borderWidth = 2.0;
        //边框颜色
        textField.layer.borderColor = UIColor.red.cgColor
        //文字提示文字
        textField.placeholder = "最多6位";
        
        //文字超过文本框时自动缩小字号而不隐藏
        textField.adjustsFontSizeToFitWidth = true;
        textField.minimumFontSize = 14; //最小可缩小字号
        
        //文字水平对齐
        textField.textAlignment = .left;
        //文字垂直对齐
        textField.contentVerticalAlignment = .top;
        
        //设置背景图片
        textField.borderStyle = .none;//先抹除边框样式
        textField.background = UIImage(named:"");
        
        //右侧 x
        /*.whileEditing//编辑时出现
         .unlessEditing//编辑时不出现,编辑后才出现
         .always一直显示清除按钮
         */
        textField.clearButtonMode = .whileEditing // 编辑时出现
        
        //密码模式
        textField.isSecureTextEntry = true;
        //键盘
        /*
         UIKeyboardType.numberPad;数字
         .Default:默认
         ascll capable:英文
         phone pad:电话
         emall:邮件
         */
        textField.keyboardType = UIKeyboardType.numberPad;
        //获取焦点并弹出输入键盘
        textField.becomeFirstResponder();
        
        //失去焦点 收回键盘
        textField.resignFirstResponder();
        
        //键盘return模式
        textField.returnKeyType = .done;
        /*
         .done 完成输入
         .go 完成输入,跳转另一个界面
         .search.搜
         .join:组册
         ,next:下一步
         ,send:发送
         
         */
    }
    
    //MARK:--点击空白处关闭键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        textField.resignFirstResponder()
        //或者 self.view?.endEditing(true)
        
    }
    
    
    //MARK:--点击键盘return响应函数
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //输入框按下键盘 return 收回键盘 
        textField.resignFirstResponder()
        //打印出文本框中的值
        print(textField.text ?? "")
        return true
    }
    //    MARK:--textfield代理(是否可以编辑 true可以编辑)
      func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("我要开始编辑了...")
            return true;
        }
    //MARK:--进入编辑
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("我正在编辑状态中...")
    }
    // 输入框将要将要结束编辑
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("我即将编辑结束...")
        return true
    }

    //MARK:--结束编辑
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("我已经结束编辑状态...")
    }
    //MARK:--该方法可以实时获取到文本最新内容
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print(textField.text!)
//        return true;
        //MARK: 限制输入
        let text = textField.text!
        let len = text.count + string.count - range.length
        return len<=6
    }
}

