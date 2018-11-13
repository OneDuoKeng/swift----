//
//  ViewController.swift
//  swift--UITextView实例
//
//  Created by 研发ios工程师 on 2018/11/8.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextViewDelegate{
   
    let textview = UITextView(frame: CGRect(x: 30, y: 80, width: 250, height: 100))
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: 一、创建
        // 1 UITextView优势:弥补textfield单行输入的缺点,弥补lable显示固定行数的缺点。
        textview.layer.borderWidth = 0.4
        textview.layer.cornerRadius = 4
        textview.layer.borderColor = UIColor.red.cgColor
        textview.layer.masksToBounds = true
        textview.becomeFirstResponder()
        self.view.addSubview(textview)
        
        //MARK: 二、常用的控件API
        //2.1，是否可以被编辑,返回false,就是readOnly
        textview.isEditable = true
        //2.2，内容是否可选
        textview.isSelectable = true
        
        //2.3，属性font设置字体，textColor设置字体颜色，textAlignment设置对齐方式
        textview.textColor = UIColor.red//设置字体颜色
        textview.textAlignment = .center //设置对齐方式
        
        //2.4，当文本是电话或者是一个网址,那么高亮显示,点击并跳转或者拨打电话
        textview.dataDetectorTypes = [] //都不加链接
        textview.dataDetectorTypes = .phoneNumber //只有电话加链接
        textview.dataDetectorTypes = .link //只有网址加链接
        textview.dataDetectorTypes = .all //全部都加
        textview.dataDetectorTypes = .calendarEvent //日历
        if #available(iOS 10.0, *) {
            textview.dataDetectorTypes = .shipmentTrackingNumber
        } else {
            // Fallback on earlier versions
        } //货单号
        if #available(iOS 10.0, *) {
            textview.dataDetectorTypes = .flightNumber
        } else {
            // Fallback on earlier versions
        } //班机号
        if #available(iOS 10.0, *) {
            textview.dataDetectorTypes = .lookupSuggestion
        } else {
            // Fallback on earlier versions
        } //查看建议
        
        //2.5 对选定文字进行加粗、下划线等操作
        textview.allowsEditingTextAttributes = true
        
        //2.6 避免用户对选定一定范围内文本进行copy 指定光标一定到指定位置,如果设置selectable为false的话,文字不能被选择,防止用户copy
        textview.scrollRangeToVisible(NSMakeRange(0, 10));
//        textview.isSelectable = false
        
        //MARK: 三、代理
        textview.delegate = self
        
    }

    //MARK:3.1 编辑开始被调用,返回false,编辑不会被开始
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    //MARK:3.2 编辑结束前调用,返回false,编辑不会结束,光标一直存在
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
        
    }

    //MARK:3.3 改变文本前被调用,向range中设置变化范围,text中设置变化后的字符串,返回false,变化将不会反应
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print(textView.text);
        return true
        
    }
    
    //MARK:3.4 编辑开始后被调用,获取焦点被调用
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(textView.text)
        
    }
    
    //MARK:3.5 编辑结束后调用
    func textViewDidEndEditing(_ textView: UITextView) {
        print(textView.text)
        
    }
   
    //MARK:3.6 文本变更时被调用(结果是每输入一个字符时都会被调用)
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        
    }
   
    //MARK:3.7 游标移动,选择范围发生变化时被调用
    func textViewDidChangeSelection(_ textView: UITextView) {
        print(textView.text)
        
        if textView.text.count > 10 {
            
            //获得已输出字数与正输入字母数
            let selectRange = textView.markedTextRange
            
            //获取高亮部分 － 如果有联想词则解包成功
            if let selectRange = selectRange {
                let position =  textView.position(from: (selectRange.start), offset: 0)
                if (position != nil) {
                    return
                }
            }
            
            let textContent = textView.text
            let textNum = textContent?.count
            
            //截取200个字
            if textNum! > 20 {
                _ = textContent?.index((textContent?.startIndex)!, offsetBy: 20)
               
                let sub1 = textContent?.prefix(10)
                textView.text = String(sub1 ?? "什么鬼")
            }
        }
    }
//    注意: UITextview并没有像UITextField控件有textFieldShouldReturn监听点击return回车键,因为在多行文本控件中,点击return键被意味着是正常的换行行为。因为,我们需要在界面中自己增加一个完成按钮,点击按钮后调用UITextview的resgisterFirstResponde方法,从而收起键盘。
    
    //MARK:--点击空白处关闭键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        textview.resignFirstResponder()
        //或者 self.view?.endEditing(true)
        
    }
}

