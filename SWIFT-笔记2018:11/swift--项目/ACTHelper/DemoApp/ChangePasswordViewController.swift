//
//  ChangePasswordViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/5/3.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import Toaster
import PKHUD

class ChangePasswordViewController: BaseAccountSettingViewController {

    var prevPassword : FormRowBlack!
    var newPassword : FormRowBlack!
    var repeatPassword : FormRowBlack!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.lblTitle.text = "更换密码"
        btSubmit.bt.addTarget(self, action: #selector(ChangePasswordViewController.submit(_:)), for: .touchUpInside)
        
        prevPassword = FormRowBlack(frame: CGRect(x: 0, y: 70, width: Int(self.view.frame.size.width), height: 90))
        prevPassword.setValueType(type: FieldType.Password)
        prevPassword.controller = self
        prevPassword.labelTitle.text = "输入原密码"
        self.topView.addSubview(prevPassword)
        
        newPassword = FormRowBlack(frame: CGRect(x: 0, y: 165, width: Int(self.view.frame.size.width), height: 90))
        newPassword.setValueType(type: FieldType.Password)
        newPassword.controller = self
        newPassword.labelTitle.text = "输入新密码"
        self.topView.addSubview(newPassword)
        
        repeatPassword = FormRowBlack(frame: CGRect(x: 0, y: 260, width: Int(self.view.frame.size.width), height: 90))
        repeatPassword.setValueType(type: FieldType.Password)
        repeatPassword.controller = self
        repeatPassword.labelTitle.text = "再次输入密码"
        self.topView.addSubview(repeatPassword)
        
        topViewFrame = CGRect(x: topViewFrame.origin.x, y: topViewFrame.origin.y, width: topViewFrame.size.width, height: topViewFrame.size.height + 120)
        self.topView.frame = topViewFrame
        
        
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
            if(self.focusedFieldType == "输入原密码")
            {
                newY = -10
            }
            else if(self.focusedFieldType == "输入新密码")
            {
                newY = -105
            }
            else if(self.focusedFieldType == "再次输入密码")
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
    
    override func checkForm()
    {
        if self.prevPassword.isPass && self.newPassword.isPass && self.repeatPassword.isPass
        {
            self.btSubmit.active()
        }
        else
        {
            self.btSubmit.deActive()
        }
    }
    
    func checkFormAgain() -> Bool
    {
        prevPassword.isPass = false
        newPassword.isPass = false
        repeatPassword.isPass = false
        
        _ = prevPassword.checkValue()
        _ = newPassword.checkValue()
        _ = repeatPassword.checkValue()
        
        if self.prevPassword.isPass && self.newPassword.isPass && self.repeatPassword.isPass
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
        
        let oldPassword = self.prevPassword.getValue()
        let newPassword = self.newPassword.getValue()
        let repeatPassword = self.repeatPassword.getValue()
        
        if(newPassword != repeatPassword)
        {
            self.view.endEditing(true)
            ToastView.appearance().bottomOffsetPortrait = 150
            Toast(text: "新密码和再次输入的密码不一致！").show()
            return
        }
        
        let url = "\(self.baseUrl)iOS/changeUserInfo.json"
        let parameters = ["old": AESUtil.encrypt(encryptData: oldPassword) , "new": AESUtil.encrypt(encryptData: newPassword)]
        
        HUD.show(.progress)
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON
            { response in
                
                HUD.hide(animated: true)
                
                if let json = response.result.value as? [String: Any]
                {
                    print("JSON: \(json)")
                    let code = json["code"] as? Int ?? 0
                    
                    ToastView.appearance().bottomOffsetPortrait = 150
                    if(code == 0)
                    {
                        //修改记录
                        DataUtil.setLoginOut()
                        //Toast(text: "密码更换成功，请重新登陆！").show()
                        
                        let vc = LoginController()
                        vc.shouldHideBackButton = true
                        vc.showToastAfterChangingPasword = true
                        
                        let userInfo = DataUtil.getCrtUser()
                        if userInfo.isHaiWai
                        {
                            vc.loginType = .Overseas
                        }
                        
                        let navigationVc = UINavigationController(rootViewController: vc)
                        UIApplication.shared.delegate?.window??.rootViewController = navigationVc
                        
                    }
                    else if(code == 4002)
                    {
                        Toast(text: "旧密码错误。").show()
                    }
                    else
                    {
                        Toast(text: "操作失败，请重新尝试。").show()
                    }
                }
                else
                {
                    self.view.endEditing(true)

                    ToastView.appearance().bottomOffsetPortrait = 150
                    Toast(text: "操作失败，请重新尝试。").show()
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
