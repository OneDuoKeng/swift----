//
//  FormRow.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/11.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
enum FieldType
{
    case Tel
    case Email
    case Password
    case VerifyCode
    case NickName
}

struct RegexHelper
{
    let regex: NSRegularExpression?
    
    init(_ pattern: String)
    {
        do
        {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        }
        catch
        {
            regex = nil
        }
    }
    
    func match(_ input: String) -> Bool
    {
        let len = input.characters.count
        let range = NSMakeRange(0, len)
        if let matches = regex?.matches(in: input,
                                        options: .reportProgress,
                                        range: range)
        {
            return matches.count > 0
        }
        else
        {
            return false
        }
    }
}

class FormRow: UIView, UITextFieldDelegate {

    var isPass : Bool = false
    var labelTitle : UILabel!
    var labelError : UILabel!
    var inputField : UITextField!
    var line : UIView!
    weak var controller : BaseLoginRegViewController!
    
    var valueType : FieldType = FieldType.Tel //0:tel, 1:email, 2:password  3:verifycode  4:username
    var correctVerifyCode = ""
    var frameError : CGRect!
    
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
        labelTitle.textColor = .white
        labelTitle.font = UIFont(name: "PingFang SC", size: 14)
        self.addSubview(labelTitle)
        
        let frameInput = CGRect(x: 20, y: 20, width: frame.size.width-40, height: 40)
        inputField = UITextField(frame: frameInput)
        inputField.delegate = self
        inputField.textColor = .white
        inputField.clearButtonMode = .whileEditing
        inputField.font = UIFont(name: "PingFang SC", size: 17)
        self.addSubview(inputField)
        
        
        line = UIView(frame: CGRect(x: 20, y: 64, width: frame.size.width-40, height: 1))
        line.backgroundColor = UIColor.white
        self.addSubview(line)
        
        frameError = CGRect(x: 20, y: 69, width: frame.size.width-40, height: 14)
        labelError = UILabel(frame: frameError)
        labelError.textColor = UIColor(red: 255.0/255, green: 89.0/255, blue: 95.0/255, alpha: 1.0)
        labelError.font = UIFont(name: "PingFang SC", size: 10)!
        labelError.isHidden = true
        self.addSubview(labelError)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(FormRow.enteringContent(_:)),
                                               name: NSNotification.Name.UITextFieldTextDidChange,
                                               object: nil)
    }
    
    func getValue() -> String
    {
        return inputField.text!
    }
    
    func setValueType(type : FieldType)
    {
        self.valueType = type
        
        if(type == .Tel)
        {
            self.inputField.keyboardType = UIKeyboardType.phonePad
            self.labelTitle.text = "电话号码"
            
        }
        else if(type == .Email)
        {
            self.inputField.keyboardType = UIKeyboardType.emailAddress
            self.labelTitle.text = "邮箱地址"
        }
        else if(type == .Password)
        {
            self.inputField.keyboardType = UIKeyboardType.URL
            self.inputField.isSecureTextEntry = true
            self.labelTitle.text = "密码"
        }
        else if(type == .VerifyCode)
        {
            self.inputField.keyboardType = UIKeyboardType.numberPad
            self.labelTitle.text = "验证码"
        }
        else if(type == .NickName)
        {
            self.inputField.keyboardType = UIKeyboardType.namePhonePad
            self.labelTitle.text = "用户昵称"
        }
    }
    
    func checkIsNotBlank()
    {
        if self.getValue() != ""
        {
            self.isPass = true
            self.controller.checkForm()
        }
        else
        {
            self.isPass = false
            self.controller.checkForm()
        }
    }
    
    func checkValue() -> Bool
    {
        if(self.valueType == .Tel)
        {
            let pattern = "^1[0-9]{10}$"
            let matcher = RegexHelper(pattern)
            
            if !matcher.match(self.getValue())
            {
                self.setError(info: "电话号码输入有误")
                return false
            }
        }
        else if(self.valueType == .Email)
        {
            let pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            let matcher = RegexHelper(pattern)
            
            let value = self.getValue()
            if !matcher.match(value)
            {
                self.setError(info: "邮箱地址输入有误")
                return false
            }
        }
        else if(self.valueType == .Password)
        {
            let pattern = "^[a-z0-9_-]{6,16}$"
            let matcher = RegexHelper(pattern)
            
            if !matcher.match(self.getValue())
            {
                self.setError(info: "密码输入有误")
                return false
            }
        }
        else if(self.valueType == .VerifyCode)
        {
            let pattern = "^[0-9]{6,6}$"
            let matcher = RegexHelper(pattern)
            
            if !matcher.match(self.getValue())
            {
                self.setError(info: "验证码输入有误")
                return false
            }
        }
        else if(self.valueType == .NickName)
        {
            let pattern = "^[0-9_-a-zA-Z\\u4E00-\\u9FA5]{2,100}$"
            let matcher = RegexHelper(pattern)
            
            if !matcher.match(self.getValue())
            {
                self.setError(info: "用户名称输入有误")
                return false
            }
        }
        
        self.setSuccess()
        return true
    }
    
    func setError(info : String)
    {
        self.isPass = false
        self.labelError.text = info
        self.labelError.isHidden = false
        
        let rect = CGRect(x: frameError.origin.x, y: frameError.origin.y - 20, width: frameError.size.width, height: frameError.size.height)
        self.labelError.frame = rect
        self.labelError.layer.opacity = 0.0
        
        self.labelTitle.textColor = .white
        self.inputField.textColor = .white
        self.line.backgroundColor = .white
        
        UIView.beginAnimations("switchToDaLu", context: nil)
        UIView.setAnimationDuration(0.6)
        
        self.labelError.layer.opacity = 1.0
        self.labelError.frame = self.frameError
        self.labelTitle.textColor = self.labelError.textColor
        self.inputField.textColor = self.labelError.textColor
        self.line.backgroundColor = self.labelError.textColor
        
        UIView.commitAnimations()
        
        self.controller.checkForm()
    }
    
    func setSuccess()
    {
        UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveLinear, animations: {
            
            self.isPass = true
            let rect = CGRect(x: self.frameError.origin.x, y: self.frameError.origin.y - 20, width: self.frameError.size.width, height: self.frameError.size.height)
            self.labelError.frame = rect
            self.labelError.layer.opacity = 0.0
            
            self.labelTitle.textColor = .white
            self.inputField.textColor = .white
            self.line.backgroundColor = .white
            
            self.controller.checkForm()
            
        }, completion: { finished in
            self.labelError.isHidden = true
        })
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.controller.focusedFieldType = self.valueType
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let count = inputField.subviews.count
        
        if count >= 2
        {
            let bt = inputField.subviews[1] as! UIButton
            bt.imageView?.image = bt.imageView?.image?.blendColor(.white, blendMode: .destinationIn)
        }
        var maxNum = 11
        if(self.valueType == .Password)
        {
            maxNum = 16
        }
        else if(self.valueType == .VerifyCode)
        {
            maxNum = 6
        }
        else if(self.valueType == .NickName)
        {
            maxNum = 100
        }
        else if(self.valueType == .Email)
        {
            maxNum = 100
        }
        
        let txt = textField.text
        let str = "\(txt!)\(string)"
        if str.lengthOfBytes(using: .utf8) <= maxNum
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func enteringContent(_ notification: Notification?)
    {
        self.checkIsNotBlank()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
