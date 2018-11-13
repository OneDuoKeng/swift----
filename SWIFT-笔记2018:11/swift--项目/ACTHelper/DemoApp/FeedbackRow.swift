//
//  FeedbackRow.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/11.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class FeedbackRow: UIView, UITextFieldDelegate {

    var isPass : Bool = false
    var labelTitle : UILabel!
    var inputField : UITextField!
    var line : UIView!
    weak var controller : FeedBackViewController!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let frameTitle = CGRect(x: 20, y: 0, width: frame.size.width-40, height: 20)
        labelTitle = UILabel(frame: frameTitle)
        labelTitle.textColor = UIColor(red: 74.0/255, green: 74.0/255, blue: 74.0/255, alpha: 1.0)
        labelTitle.font = UIFont(name: "PingFang SC", size: 14)
        labelTitle.text = "写下您的反馈"
        self.addSubview(labelTitle)
        
        let frameInput = CGRect(x: 20, y: 20, width: frame.size.width-40, height: 40)
        inputField = UITextField(frame: frameInput)
        inputField.delegate = self
        inputField.textColor = UIColor(red: 74.0/255, green: 74.0/255, blue: 74.0/255, alpha: 1.0)
        inputField.font = UIFont(name: "PingFang SC", size: 17)
        inputField.keyboardType = UIKeyboardType.default
        self.addSubview(inputField)
        
        line = UIView(frame: CGRect(x: 20, y: 64, width: frame.size.width-40, height: 1))
        line.backgroundColor = UIColor(red: 230.0/255, green: 230.0/255, blue: 230.0/255, alpha: 1.0)
        self.addSubview(line)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(FeedbackRow.enteringContent(_:)),
                                               name: NSNotification.Name.UITextFieldTextDidChange,
                                               object: nil)
    }
    
    func getValue() -> String
    {
        return inputField.text!
    }
    
    func checkValue() -> Bool
    {
        if(self.inputField.text == "")
        {
            self.setError()
            return false
        }
        
        self.setSuccess()
        return true
    }
    
    func setError()
    {
        self.isPass = false
        
        UIView.beginAnimations("switchToDaLu", context: nil)
        UIView.setAnimationDuration(0.6)
        
        self.labelTitle.textColor = self.controller.fontColorDarkGray
        self.inputField.textColor = self.controller.fontColorDarkGray
        self.line.backgroundColor = self.controller.fontColorLightGray
        
        UIView.commitAnimations()
        
        self.controller.checkForm()
    }
    
    func setSuccess()
    {
        UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveLinear, animations: {
            
            self.isPass = true
            
            self.labelTitle.textColor = self.controller.fontColorGreen
            self.inputField.textColor = self.controller.fontColorGreen
            self.line.backgroundColor = self.controller.fontColorGreen
            
            self.controller.checkForm()
            
        }, completion: { finished in
            
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.inputField.resignFirstResponder()
        return true
    }
    
    func enteringContent(_ notification: Notification?)
    {
        _ = self.checkValue()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
