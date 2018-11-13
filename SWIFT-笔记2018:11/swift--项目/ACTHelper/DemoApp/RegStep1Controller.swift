//
//  RegStep1Controller.swift
//  DemoApp
//
//  Created by Jerry on 2017/3/31.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import Toaster
import PKHUD

enum RegType {
    case Mainland
    case Overseas
}

class RegStep1Controller: BaseLoginRegViewController {

    var loginType : RegType = .Mainland
    var userInfo : UserInfo!
    
    var switchMainland : UIButton!
    var switchOverseas : UIButton!
    
    var mainlandLoginArea : UIView!
    var overseasLoginArea : UIView!
    var footArea : UIView!
    
    var rowTel : FormRow!
    var rowEmail : FormRow!
    var submit : RegButton!
    
    var titleMainland : UILabel!
    var titleOverseas : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        userInfo = UserInfo()
        
        mainlandLoginArea = UIView(frame: CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 350))
        self.view.addSubview(mainlandLoginArea)
        
        titleMainland = UILabel(frame: CGRect(x: 20, y: 0, width: 220, height: 20))
        titleMainland.font = UIFont.boldSystemFont(ofSize: 24)
        titleMainland.textColor = UIColor.white
        titleMainland.text = "中国大陆用户注册"
        mainlandLoginArea.addSubview(titleMainland)
        
        let subTitle = UILabel(frame: CGRect(x: 20, y: 30, width: 220, height: 20))
        subTitle.font = UIFont.boldSystemFont(ofSize: 14)
        subTitle.textColor = UIColor.white
        subTitle.text = "请输入中国大陆11位手机号码"
        mainlandLoginArea.addSubview(subTitle)
        
        rowTel = FormRow(frame: CGRect(x: 0, y: 70, width: Int(self.view.frame.size.width), height: 90))
        rowTel.setValueType(type: FieldType.Tel)
        rowTel.controller = self
        mainlandLoginArea.addSubview(rowTel)
        
        overseasLoginArea = UIView(frame: CGRect(x: self.view.frame.size.width, y: 80, width: self.view.frame.size.width, height: 350))
        overseasLoginArea.layer.opacity = 0.0
        self.view.addSubview(overseasLoginArea)
        
        titleOverseas = UILabel(frame: CGRect(x: 20, y: 0, width: 280, height: 20))
        titleOverseas.font = UIFont.boldSystemFont(ofSize: 24)
        titleOverseas.textColor = UIColor.white
        titleOverseas.text = "港澳台及海外用户注册"
        overseasLoginArea.addSubview(titleOverseas)
        
        let subTitle2 = UILabel(frame: CGRect(x: 20, y: 30, width: 220, height: 20))
        subTitle2.font = UIFont.boldSystemFont(ofSize: 14)
        subTitle2.textColor = UIColor.white
        subTitle2.text = "请输入您的邮箱注册"
        overseasLoginArea.addSubview(subTitle2)
        
        rowEmail = FormRow(frame: CGRect(x: 0, y: 70, width: Int(self.view.frame.size.width), height: 90))
        rowEmail.setValueType(type: FieldType.Email)
        rowEmail.controller = self
        overseasLoginArea.addSubview(rowEmail)
        
        footArea = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - 60, width: self.view.frame.size.width, height: 60))
        self.view.addSubview(footArea)
        
        let posX3 = self.view.frame.size.width - 90 - 20
        submit = RegButton(frame: CGRect(x: posX3, y: 0, width: 90, height: 37))
        submit.bt.setTitle("获取验证码", for: .disabled)
        submit.bt.setTitle("获取验证码", for: .normal)
        submit.bt.addTarget(self, action: #selector(RegStep1Controller.submit(_:)), for: .touchUpInside)
        footArea.addSubview(submit)
        
        let switchFrame = CGRect(x:20, y: 0, width:143, height:37)
        switchOverseas = UIButton(frame: switchFrame)
        switchOverseas.titleLabel?.font = self.font14
        switchOverseas.setTitle("港澳台及海外用户注册", for: .normal)
        switchOverseas.addTarget(self, action: #selector(RegStep1Controller.switchToOverseas(_:)), for: .touchUpInside)
        footArea.addSubview(switchOverseas)
        
        let switchFrame2 = CGRect(x:20, y: 0, width:115, height:37)
        switchMainland = UIButton(frame: switchFrame2)
        switchMainland.titleLabel?.font = self.font14
        switchMainland.setTitle("中国大陆用户注册", for: .normal)
        switchMainland.addTarget(self, action: #selector(RegStep1Controller.switchToMainland(_:)), for: .touchUpInside)
        switchMainland.isHidden = true
        footArea.addSubview(switchMainland)
        
        self.rowTel.inputField.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RegStep1Controller.keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RegStep1Controller.keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
 
    }
    
    // MARK:
    // MARK:switchToOverseas
    func switchToOverseas(_ sender:UIButton)
    {
        self.loginType = .Overseas
        switchMainland.isHidden = false
        switchOverseas.isHidden = true
        self.hideKeyboard()
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            
            self.mainlandLoginArea.center = CGPoint(x: self.view.frame.size.width * -1/2, y: self.mainlandLoginArea.center.y)
            self.overseasLoginArea.center = CGPoint(x: self.view.frame.size.width/2, y: self.overseasLoginArea.center.y)
            self.mainlandLoginArea.layer.opacity = 0.0
            self.overseasLoginArea.layer.opacity = 1.0
            
        }, completion: { finished in
            self.rowEmail.inputField.becomeFirstResponder()
        })
        
        self.checkForm()
    }
    
    func switchToMainland(_ sender:UIButton)
    {
        self.loginType = .Mainland
        switchMainland.isHidden = true
        switchOverseas.isHidden = false
        self.hideKeyboard()
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            
            self.mainlandLoginArea.center = CGPoint(x: self.view.frame.size.width/2, y: self.mainlandLoginArea.center.y)
            self.overseasLoginArea.center = CGPoint(x: self.view.frame.size.width*3/2, y: self.overseasLoginArea.center.y)
            self.mainlandLoginArea.layer.opacity = 1.0
            self.overseasLoginArea.layer.opacity = 0.0
            
        }, completion: { finished in
            self.rowTel.inputField.becomeFirstResponder()
        })
        
        self.checkForm()
    }
    
    // MARK:
    // MARK:keyboardWillShow
    func keyboardWillShow(_ notification: Notification?)
    {
        var keyboardH = Int(self.getKeyboardHeight())
        if(self.focusedFieldType == .Email)
        {
            keyboardH += 30
        }
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
            if rowTel.isPass
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
            if rowEmail.isPass
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
        if(self.loginType == .Mainland)
        {
            rowTel.isPass = false
            
            _ = rowTel.checkValue()
            
            if rowTel.isPass
            {
                return true
            }
            else
            {
                return false
            }
        }
        else
        {
            rowEmail.isPass = false
            
            _ = rowEmail.checkValue()
            
            if rowEmail.isPass
            {
                return true
            }
            else
            {
                return false
            }
        }
    }
    
    func submit(_ sender : UIButton)
    {
        if(!self.checkFormAgain())
        {
            self.submit.active()
            return
        }
        
        var parameters : Dictionary<String, String>
        if self.loginType == .Mainland
        {
            print("中国大陆用户注册")
            self.userInfo.isHaiWai = false
            self.userInfo.phone = self.rowTel.getValue()
            parameters = ["phone": self.rowTel.getValue()]
        }
        else
        {
            print("港澳台及海外用户注册")
            self.userInfo.isHaiWai = true
            self.userInfo.email = self.rowEmail.getValue()
            parameters = ["email": self.rowEmail.getValue()]
        }
        
        let url = "\(self.baseUrl)iOS/auth_code.json"
        
        self.hideKeyboard()
        
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
                        let vc = RegStep2Controller()
                        vc.userInfo = self.userInfo
                        self.navigationController?.pushViewController(vc, animated: true)
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
