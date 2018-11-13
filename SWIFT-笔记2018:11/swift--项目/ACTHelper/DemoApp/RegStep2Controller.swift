//
//  RegStep2Controller.swift
//  DemoApp
//
//  Created by Jerry on 2017/3/31.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import Toaster
import PKHUD

class RegStep2Controller: BaseLoginRegViewController {

    var loginType : RegType = .Mainland
    var userInfo : UserInfo!
    var mainArea : UIView!
    var footArea : UIView!
    var rowVerify : FormRow!
    var submit : RegButton!
    var btFreshCode : RegButton!
    var titleVerifyCode : UILabel!
    var baseTime : Int = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mainArea = UIView(frame: CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 350))
        self.view.addSubview(mainArea)
        
        titleVerifyCode = UILabel(frame: CGRect(x: 20, y: 0, width: self.view.frame.size.width - 40, height: 20))
        titleVerifyCode.font = UIFont.boldSystemFont(ofSize: 24)
        titleVerifyCode.textColor = UIColor.white
        titleVerifyCode.text = "填写验证码"
        mainArea.addSubview(titleVerifyCode)
        
        let subTitle = UILabel(frame: CGRect(x: 20, y: 30, width: self.view.frame.size.width - 40, height: 20))
        subTitle.font = UIFont.boldSystemFont(ofSize: 14)
        subTitle.textColor = UIColor.white
        if self.userInfo.isHaiWai
        {
            subTitle.text = "请您查看邮箱并在此输入收到的验证码。"
        }
        else
        {
            subTitle.text = "请您查看手机并在此输入收到的验证码。"
        }
        
        mainArea.addSubview(subTitle)
        
        rowVerify = FormRow(frame: CGRect(x: 0, y: 70, width: Int(self.view.frame.size.width), height: 90))
        rowVerify.setValueType(type: FieldType.VerifyCode)
        rowVerify.controller = self
        mainArea.addSubview(rowVerify)
        
        footArea = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - 60, width: self.view.frame.size.width, height: 60))
        self.view.addSubview(footArea)
        
        let posX3 = self.view.frame.size.width - 90 - 20
        submit = RegButton(frame: CGRect(x: posX3, y: 0, width: 90, height: 37))
        submit.bt.setTitle("确认提交", for: .disabled)
        submit.bt.setTitle("确认提交", for: .normal)
        submit.bt.addTarget(self, action: #selector(RegStep2Controller.submit(_:)), for: .touchUpInside)
        footArea.addSubview(submit)
        
        let codeFrame = CGRect(x:20, y: 0, width:117, height:37)
        btFreshCode = RegButton(frame: codeFrame)
        btFreshCode.bt.setTitle("重新获取 60S", for: .disabled)
        btFreshCode.bt.setTitle("重新获取 60S", for: .normal)
        btFreshCode.bt.setTitleColor(UIColor(red: 0.0/255, green: 126.0/255, blue: 125.0/255, alpha: 1.0), for: .disabled)
        btFreshCode.bt.addTarget(self, action: #selector(RegStep2Controller.refreshCode(_:)), for: .touchUpInside)
        footArea.addSubview(btFreshCode)
        
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RegStep2Controller.timerAction(_:)), userInfo: "infomation", repeats: true)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RegStep2Controller.keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RegStep2Controller.keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
 
    }
    
    // MARK:
    // MARK:keyboardWillShow
    func keyboardWillShow(_ notification: Notification?)
    {
        var keyboardH = Int(self.getKeyboardHeight())
        
        if(self.view.frame.width == 414)
        {
            keyboardH += 10
        }
        
        let frame = CGRect(x: 0, y: Int(self.view.frame.size.height) - 60 - keyboardH, width: Int(self.view.frame.size.width), height: 60)
        
        UIView.beginAnimations("keyboardWillShow", context: nil)
        
        UIView.setAnimationDuration(0.2)
        self.footArea.frame = frame
        
        UIView.commitAnimations()
    }
    
    func keyboardWillHide(_ notification: Notification?)
    {
        let frame = CGRect(x: 0, y: Int(self.view.frame.size.height) - 60, width: Int(self.view.frame.size.width), height: 60)
        
        UIView.beginAnimations("keyboardWillShow", context: nil)
        UIView.setAnimationDuration(0.3)
        self.footArea.frame = frame
        
        
        UIView.commitAnimations()
    }
    
    // MARK:
    // MARK:checkForm
    override func checkForm()
    {
        if(self.loginType == .Mainland)
        {
            if rowVerify.isPass
            {
                self.submit.active()
            }
            else
            {
                self.submit.deActive()
            }
        }
        else
        {
            if rowVerify.isPass
            {
                self.submit.active()
            }
            else
            {
                self.submit.deActive()
            }
        }
    }
    
    func checkFormAgain() -> Bool
    {
        rowVerify.isPass = false
        
        _ = rowVerify.checkValue()
        
        if rowVerify.isPass
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func submit(_ sender : UIButton)
    {
        if(!self.checkFormAgain())
        {
            self.submit.active()
            return
        }
        
        self.userInfo.verifyCode = self.rowVerify.getValue()
        
        let vc = RegStep3Controller()
        vc.userInfo = self.userInfo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func refreshCode(_ sender : UIButton)
    {
        baseTime = 60
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RegStep2Controller.timerAction(_:)), userInfo: "infomation", repeats: true)
        
        btFreshCode.deActive()
        btFreshCode.bt.setTitle("重新获取 \(baseTime)S", for: .disabled)
        btFreshCode.bt.setTitle("重新获取 \(baseTime)S", for: .normal)
        btFreshCode.bt.setTitleColor(UIColor(red: 0.0/255, green: 126.0/255, blue: 125.0/255, alpha: 1.0), for: .disabled)
        
        var parameters : Dictionary<String, String>
        if !self.userInfo.isHaiWai
        {
            parameters = ["phone": self.userInfo.phone]
        }
        else
        {
            parameters = ["email": self.userInfo.email]
        }
        
        let url = "\(self.baseUrl)iOS/auth_code.json"
        
        HUD.show(.progress)
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON
            { response in
                
                HUD.hide(animated: true)
                
                if let json = response.result.value as? [String: Any]
                {
                    print("JSON: \(json)")
                    let code = json["code"] as? Int ?? 0
                    let detail = json["detail"] as? String ?? ""
                    
                    if(code == 0)
                    {
                        self.rowVerify.inputField.becomeFirstResponder()
                    }
                    else
                    {
                        ToastView.appearance().font = self.font14
                        ToastView.appearance().bottomOffsetPortrait = 100
                        Toast(text: detail).show()
                    }
                }
                else
                {
                    ToastView.appearance().font = self.font14
                    ToastView.appearance().bottomOffsetPortrait = 100
                    Toast(text: "获取验证码失败。").show()
                }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.rowVerify.inputField.becomeFirstResponder()
    }

    
    func timerAction(_ timer:Timer)
    {
        baseTime -= 1
        
        if(baseTime <= 0)
        {
            btFreshCode.bt.setTitle("重新获取", for: .disabled)
            btFreshCode.bt.setTitle("重新获取", for: .normal)
            btFreshCode.active()
            timer.invalidate()
        }
        else
        {
            btFreshCode.bt.setTitle("重新获取 \(baseTime)S", for: .disabled)
            btFreshCode.bt.setTitle("重新获取 \(baseTime)S", for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
