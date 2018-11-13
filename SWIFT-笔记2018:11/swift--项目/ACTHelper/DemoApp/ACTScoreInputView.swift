//
//  ACTScoreInputView.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/24.
//  Copyright © 2017年 www.coolketang.com. All rights reserved.
//

import UIKit

class ACTScoreInputView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var controller : RegStep7Controller!
    var scores = [0, 0, 0, 0, 0]
    var crtItem = 0
    var pickerContainer : UIView!
    var picker : UIPickerView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func buildUIWithController(controller : RegStep7Controller)
    {
        self.controller = controller
        
        let labels = ["考试总分","英语总分","数学总分","阅读总分","科学总分"]
        
        let width = Int(frame.size.width) - 40
        
        for i in 0 ... 4
        {
            let label = UILabel(frame: CGRect(x: 20, y: 20 + 60*i, width: width, height: 20))
            label.textColor = .white
            label.font = controller.font14
            label.text = labels[i]
            self.addSubview(label)
            
            let posX = Int(frame.size.width) - 20 - 80
            let bt = UIButton(frame: CGRect(x: posX, y: 0 + 60*i, width: 80, height: 60))
            bt.setTitle("点击填写", for: .normal)
            bt.addTarget(self, action: #selector(ACTScoreInputView.chooseScore(_:)), for: .touchUpInside)
            bt.tag = i + 1
            bt.titleLabel?.font = controller.font14
            bt.titleLabel?.textColor = controller.fontColorRed
            bt.contentHorizontalAlignment = .right
            self.addSubview(bt)
            
            let line = UIView(frame: CGRect(x: 20, y: 60 + 60*i, width: width, height: 1))
            line.backgroundColor = controller.fontColorSplit
            self.addSubview(line)
        }
        
        pickerContainer = UIView(frame: controller.view.frame)
        pickerContainer.isHidden = true
        pickerContainer.layer.opacity = 0.0
        controller.view.addSubview(pickerContainer)
        
        let mask = UIView(frame: controller.view.frame)
        mask.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        pickerContainer.addSubview(mask)

        picker = UIPickerView(frame: CGRect(x: 0, y: controller.view.frame.size.height - 216, width: frame.size.width, height: 216))
        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = .white
        pickerContainer.addSubview(picker)
    }
    
    func chooseScore(_ sender: UIButton)
    {
        self.crtItem = sender.tag
        var score = self.scores[self.crtItem - 1]
        if(score == 0)
        {
            score = 34
        }
        
        picker.selectRow(score, inComponent: 0, animated: false)
        self.pickerContainer.isHidden = false
        print(crtItem)
        
        UIView.beginAnimations("show", context: nil)
        UIView.setAnimationDuration(0.3)
        self.pickerContainer.layer.opacity = 1.0
        UIView.commitAnimations()
        
        
        if(self.frame.size.width == 320)
        {
            if(crtItem > 1 && self.controller.userInfo.myKeMu == .ACT)
            {
                let offsetY = Int(self.controller.inputArea.contentOffset.y)
                let distance = (crtItem - 1) * 60 - offsetY - 45
                UIView.beginAnimations("scroll", context: nil)
                self.controller.scoreViewACT?.frame = CGRect(x: 0, y: Int(self.controller.scoreViewACTFrame.origin.y) - distance, width: Int(self.controller.scoreViewACTFrame.size.width), height: Int(self.controller.scoreViewACTFrame.size.height))
                UIView.commitAnimations()
            }
        }
        else if(self.frame.size.width == 375)
        {
            if(crtItem >= 3 && self.controller.userInfo.myKeMu == .ACT)
            {
                let distance = (crtItem - 2) * 60 - 30 - 45
                UIView.beginAnimations("scroll", context: nil)
                self.controller.scoreViewACT?.frame = CGRect(x: 0, y: Int(self.controller.scoreViewACTFrame.origin.y) - distance, width: Int(self.controller.scoreViewACTFrame.size.width), height: Int(self.controller.scoreViewACTFrame.size.height))
                UIView.commitAnimations()
            }
        }
        else if(self.frame.size.width == 414)
        {
            if(crtItem >= 4 && self.controller.userInfo.myKeMu == .ACT)
            {
                let distance = (crtItem - 3) * 60 - 30 - 45
                UIView.beginAnimations("scroll", context: nil)
                self.controller.scoreViewACT?.frame = CGRect(x: 0, y: Int(self.controller.scoreViewACTFrame.origin.y) - distance, width: Int(self.controller.scoreViewACTFrame.size.width), height: Int(self.controller.scoreViewACTFrame.size.height))
                UIView.commitAnimations()
            }
        }
        
    }
    
    func hidePicker()
    {
        if(!self.pickerContainer.isHidden)
        {
            let num = self.picker.selectedRow(inComponent: 0)
            let bt = self.viewWithTag(self.crtItem) as! UIButton
            bt.setTitle("\(num)", for: .normal)
            
            self.scores[self.crtItem - 1] = num
            self.controller.checkForm()
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear, animations: {
                
                self.pickerContainer.layer.opacity = 0.0
                
            }, completion: { finished in
                
                self.pickerContainer.isHidden = true
            })
            
            UIView.beginAnimations("scroll", context: nil)
            self.controller.scoreViewACT?.frame = self.controller.scoreViewACTFrame
            UIView.commitAnimations()
            
            if(self.frame.size.width == 320 && self.crtItem == 4)
            {
                let offsetSet = CGPoint(x: 0, y: 60)
                self.controller.inputArea.setContentOffset(offsetSet, animated: true)
            }
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 37
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        print(pickerView.frame)
        
        let bt = self.viewWithTag(self.crtItem) as! UIButton
        bt.setTitle("\(row)", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
