//
//  ACTScoreInputView.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/24.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class SATScoreInputView: UIView, UITextFieldDelegate {
    
    weak var controller : RegStep7Controller!
    var crtTextField : UITextField!
    var scores = [0, 0, 0]
    var crtItem = 0
    var originFrame : CGRect!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.originFrame = frame
    }
    
    func buildUIWithController(controller : RegStep7Controller)
    {
        self.controller = controller
        
        let labels = ["阅读和语法总分","数学总分","写作总分"]
        
        let width = Int(frame.size.width) - 40
        
        for i in 0 ... 2
        {
            let label = UILabel(frame: CGRect(x: 20, y: 20 + 60*i, width: width, height: 20))
            label.textColor = .white
            label.font = controller.font14
            label.text = labels[i]
            self.addSubview(label)
            
            let posX = Int(frame.size.width) - 20 - 100
            let textField = UITextField(frame: CGRect(x: posX, y: 10 + 60*i, width: 100, height: 40))
            textField.tag = i + 1
            textField.font = controller.font14
            textField.textColor = .white
            textField.delegate = self
            textField.keyboardType = .numberPad
            let attributes = [NSFontAttributeName: self.controller.font14, NSForegroundColorAttributeName: self.controller.fontColorRed]
            textField.attributedPlaceholder = NSAttributedString(string:"点击填写", attributes: attributes)
            textField.textAlignment = .right
            self.addSubview(textField)
            
            let line = UIView(frame: CGRect(x: 20, y: 60 + 60*i, width: width, height: 1))
            line.backgroundColor = controller.fontColorSplit
            self.addSubview(line)
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.crtTextField = textField
        
        if(self.frame.size.width == 320)
        {
            if(self.crtTextField.tag == 2)
            {
                UIView.beginAnimations("", context: nil)
                self.frame = CGRect(x: 0, y: originFrame.origin.y - 20, width: originFrame.size.width, height: originFrame.size.height)
                UIView.commitAnimations()
            }
            else if(self.crtTextField.tag == 3)
            {
                UIView.beginAnimations("", context: nil)
                self.frame = CGRect(x: 0, y: originFrame.origin.y - 80, width: originFrame.size.width, height: originFrame.size.height)
                UIView.commitAnimations()
            }
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        let value = textField.text
        let index = textField.tag - 1
        if value == ""
        {
            self.scores[index] = 0
        }
        else
        {
            self.scores[index] = Int(value!)!
        }
        
        
        UIView.beginAnimations("", context: nil)
        self.frame = self.originFrame
        UIView.commitAnimations()
        
        self.controller.checkForm()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var maxNum = 800
        if(textField.tag == 3)
        {
            //maxNum = 24
            maxNum = 800
        }
        
        let txt = textField.text
        let str = "\(txt!)\(string)"
        let socre = Int(str)
        if socre! <= maxNum
        {
            return true
        }
        else
        {
            return false
        }
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
