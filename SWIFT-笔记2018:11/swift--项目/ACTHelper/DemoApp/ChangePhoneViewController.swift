//
//  ChangePhoneViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/5/3.
//  Copyright © 2017年 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import Toaster
import PKHUD

class ChangePhoneViewController: BaseAccountSettingViewController {
    
    var password : FormRowBlack!
    var newPhone : FormRowBlack!
    var verifyCode : FormRowBlack!
    var btVerify : SettingButtonCount!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.lblTitle.text = "更换手机号码"
        btSubmit.bt.addTarget(self, action: #selector(ChangePhoneViewController.submit(_:)), for: .touchUpInside)
        
        password = FormRowBlack(frame: CGRect(x: 0, y: 70, width: Int(self.view.frame.size.width), height: 90))
        password.setValueType(type: FieldType.Password)
        password.controller = self
        password.labelTitle.text = "输入密码"
        self.topView.addSubview(password)
        
        newPhone = FormRowBlack(frame: CGRect(x: 0, y: 165, width: Int(self.view.frame.size.width), height: 90))
        newPhone.setValueType(type: FieldType.Tel)
        newPhone.controller = self
        newPhone.labelTitle.text = "输入新手机号码"
        self.topView.addSubview(newPhone)
        
        verifyCode = FormRowBlack(frame: CGRect(x: 0, y: 260, width: Int(self.view.frame.size.width), height: 90))
        verifyCode.setValueType(type: FieldType.VerifyCode)
        verifyCode.controller = self
        verifyCode.labelTitle.text = "输入验证码"
        self.topView.addSubview(verifyCode)
        
        topViewFrame = CGRect(x: topViewFrame.origin.x, y: topViewFrame.origin.y, width: topViewFrame.size.width, height: topViewFrame.size.height + 120)
        self.topView.frame = topViewFrame
        
        let posX = self.view.frame.size.width - 20 - 80
        btVerify = SettingButtonCount(frame: CGRect(x: posX, y: 250, width: 80, height: 40))
        btVerify.deActive()
        self.topView.addSubview(btVerify)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ChangePasswordViewController.keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ChangePasswordViewController.keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.hideTabBar()
    }
    
    // MARK:
    // MARK:键盘事件
    func keyboardWillShow(_ notification: Notification?)
    {
        var keyboardH = Int(self.getKeyboardHeight())
        if(self.view.frame.width == 320)
        {
            keyboardH -= 40
        }
        
        //动画
        UIView.beginAnimations("keyboardWillShow", context: nil)
        
        UIView.setAnimationDuration(0.2)
        let frame = CGRect(x: 0, y: Int(footAreaFrame.origin.y) - keyboardH, width: Int(footAreaFrame.size.width), height: Int(footAreaFrame.size.height))
        self.footArea.frame = frame
        
        //小屏输入区需要上移
        var newY = 21
        if(self.view.frame.size.width == 375)
        {
            newY = -10
        }
        if(self.view.frame.size.width == 320)
        {
            if(self.focusedFieldType == "输入密码")
            {
                newY = -10
            }
            else if(self.focusedFieldType == "输入新手机号码")
            {
                newY = -105
            }
            else if(self.focusedFieldType == "输入验证码")
            {
                newY = -105
            }
            
        }
        self.lblTitle.layer.opacity = 0
        self.topView.frame = CGRect(x: 0, y: newY, width: Int(self.topViewFrame.size.width), height: Int(self.topViewFrame.size.height))
        
        UIView.commitAnimations()
    }
    
    
    func keyboardWillHide(_ notification: Notification?)
    {
        UIView.beginAnimations("keyboardWillShow", context: nil)
        UIView.setAnimationDuration(0.3)
        self.footArea.frame = footAreaFrame
        
        //小屏输入区需要上移
        self.lblTitle.layer.opacity = 1
        self.topView.frame = topViewFrame
        
        UIView.commitAnimations()
    }
    
    override func checkForm() {
        if self.password.isPass && self.newPhone.isPass && self.verifyCode.isPass
        {
            self.btSubmit.active()
        }
        else
        {
            self.btSubmit.deActive()
        }
        
        if(self.newPhone.isPass && self.btVerify.baseNum == 60)
        {
            self.btVerify.active()
            self.btVerify.phone = self.newPhone.getValue()
            self.btVerify.baseUrl = self.baseUrl
            self.btVerify.willBeFocusedTextField = self.verifyCode.inputField
        }
        else
        {
            self.btVerify.deActive()
        }
    }
    
    func checkFormAgain() -> Bool
    {
        password.isPass = false
        newPhone.isPass = false
        verifyCode.isPass = false
        
        _ = password.checkValue()
        _ = newPhone.checkValue()
        _ = verifyCode.checkValue()
        
        if self.password.isPass && self.newPhone.isPass && self.verifyCode.isPass
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func submit(_ sender:UIButton)
    {
        //重新检测
        if(!self.checkFormAgain())
        {
            self.btSubmit.active()
            return
        }
        
        let phone = self.newPhone.getValue()
        let password = AESUtil.encrypt(encryptData: self.password.getValue())
        let verifyCode = self.verifyCode.getValue()
        let userInfo = DataUtil.getCrtUser()
        
        let parameters = ["phone": phone, "password": password, "code": verifyCode]
        let url = "\(self.baseUrl)iOS/changeUserInfo.json"
        
        HUD.show(.progress)
        Alamofire.request(url, method: .put, parameters: parameters).responseJSON
            { response in
                
                HUD.hide(animated: true)
                //print(response.description)
                //print(response.result)
                //print(response.data)
                
                if let json = response.result.value as? [String: Any]
                {
                    print("JSON: \(json)")
                    let code = json["code"] as? Int ?? 0
                    let detail = json["detail"] as? String ?? ""
                    
                    ToastView.appearance().bottomOffsetPortrait = 150
                    if(code == 0)
                    {
                        self.navigationController?.popViewController(animated: true)
                        
                        let userInfo = DataUtil.getCrtUser()
                        userInfo.phone = self.newPhone.getValue()
                        DataUtil.setCrtUser(userInfo: userInfo)
                        
                        Toast(text: "手机号码更换成功！").show()
                    }
                    else
                    {
                        Toast(text: detail).show()
                    }
                }
                else
                {
                    ToastView.appearance().bottomOffsetPortrait = 150
                    Toast(text: "手机号码更换失败，请重新尝试！").show()
                }
        }
    }
    
    deinit {
        //记得移除通知监听
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
