//
//  ViewController.swift
//  swift--UIPickerView实例
//
//  Created by 研发ios工程师 on 2018/11/12.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建 UIPickerView 并设置其位置大小
        let pickerView = UIPickerView(frame:CGRect(x: 20, y: 100, width:self.view.bounds.size.width, height: 200))
        // 设置代理
        pickerView.delegate = self
        pickerView.dataSource = self
        // 添加到视图上
        self.view.addSubview(pickerView)

        // 创建 UIDatePicker 并设置其位置大小
        let datePicker = UIDatePicker(frame:CGRect(x: 20, y: 250, width: pickerView.bounds.size.width, height: 200))
        // 将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = Locale(identifier: "zh_CN")
        // 点击事件：注意：action 里面的方法名后面需要加个冒号
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        // 添加到视图上
        self.view.addSubview(datePicker)
    }
   
    /*
     *** UIPickerView 代理方法
     */
    // 分组行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            
            return 5
        }else {
            return 10
        }
    }
    // 分组数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    // 每行的标题
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "第\(component + 1)组，第\(row + 1)行"
    }
    // 文字设置
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let attributed = NSMutableAttributedString(string:"第\(component + 1)组，第\(row + 1)行")
        attributed.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], range: NSRange(location: 0, length: attributed.length))
        return attributed
    }
    
    // 宽度方法
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        if component == 1 {
            
            return 280
        }else {
            return 150
        }
    }
    
    //选择控件的事件选择
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0){
            //记录用户选择的值
            //刷新第二列的数据源
            pickerView.reloadComponent(1)
            //刷新数据源后将第二组数据转到下标为0,并且开启动画效果
            pickerView.selectRow(0, inComponent: 1, animated: true)
        }
    }

    
    @objc func dateChange(datePicker: UIDatePicker) {
        // 更新提醒时间文本框
        let formatter = DateFormatter()
        // 日期格式
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        print(formatter.string(from: datePicker.date))
    }


}

