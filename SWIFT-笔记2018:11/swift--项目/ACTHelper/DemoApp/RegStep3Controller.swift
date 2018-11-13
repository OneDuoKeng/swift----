//
//  RegStep3Controller.swift
//  DemoApp
//
//  Created by Jerry on 2017/3/31.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import Toaster
import PKHUD

class RegStep3Controller: BaseLoginRegViewController {

    var userInfo : UserInfo!
    var mainArea : UIView!
    var footArea : UIView!
    var rowPassword : FormRow!
    var submit : RegButton!
    var titlePassword : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mainArea = UIView(frame: CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 350))
        self.view.addSubview(mainArea)
        
        titlePassword = UILabel(frame: CGRect(x: 20, y: 0, width: self.view.frame.size.width - 40, height: 20))
        titlePassword.font = UIFont.boldSystemFont(ofSize: 24)
        titlePassword.textColor = UIColor.white
        titlePassword.text = "设置登陆密码"
        mainArea.addSubview(titlePassword)
        
        let subTitle = UILabel(frame: CGRect(x: 20, y: 30, width: self.view.frame.size.width - 40, height: 20))
        subTitle.font = UIFont.boldSystemFont(ofSize: 14)
        subTitle.textColor = UIColor.white
        subTitle.text = "密码长度为6-16个字符，不能包含空格"
        mainArea.addSubview(subTitle)
        
        rowPassword = FormRow(frame: CGRect(x: 0, y: 70, width: Int(self.view.frame.size.width), height: 90))
        rowPassword.setValueType(type: FieldType.Password)
        rowPassword.controller = self
        mainArea.addSubview(rowPassword)
        
        footArea = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - 60, width: self.view.frame.size.width, height: 60))
        self.view.addSubview(footArea)
        
        let posX3 = self.view.frame.size.width - 90 - 20
        submit = RegButton(frame: CGRect(x: posX3, y: 0, width: 90, height: 37))
        submit.bt.setTitle("确认提交", for: .disabled)
        submit.bt.setTitle("确认提交", for: .normal)
        submit.bt.addTarget(self, action: #selector(RegStep3Controller.submit(_:)), for: .touchUpInside)
        footArea.addSubview(submit)
        
        self.rowPassword.inputField.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RegStep3Controller.keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RegStep3Controller.keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    // MARK:
    // MARK:keyboardWillShow
    func keyboardWillShow(_ notification: Notification?)
    {
        var keyboardH = Int(self.getKeyboardHeight())
        if(self.focusedFieldType == .VerifyCode)
        {
            keyboardH -= 40
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
        if rowPassword.isPass
        {
            self.submit.active()
        }
        else
        {
            self.submit.deActive()
        }
    }
    
    func checkFormAgain() -> Bool
    {
        rowPassword.isPass = false
        
        _ = rowPassword.checkValue()
        
        if rowPassword.isPass
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
        
        let password = AESUtil.encrypt(encryptData: self.rowPassword.getValue())
        self.userInfo.password = password
        
        var parameters : Dictionary<String, String>
        if !self.userInfo.isHaiWai
        {
            parameters = ["phone": self.userInfo.phone, "password": password, "code": self.userInfo.verifyCode]
        }
        else
        {
            parameters = ["email": self.userInfo.email, "password": password, "code": self.userInfo.verifyCode]
        }
        
        let url = "\(self.baseUrl)iOS/sign_up.json"
        
        HUD.show(.progress)
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON
            { response in
                
                print(response)
                HUD.hide(animated: true)
                
                if let json = response.result.value as? [String: Any]
                {
                    print("JSON: \(json)")
                    let code = json["code"] as? Int ?? 0
                    
                    if(code == 0)
                    {
                        let detail = json["detail"] as? [String: Any]
                        let userId = detail?["user"] as? Int ?? 0
                        self.userInfo.id = userId
                        
                        DataUtil.setCrtUser(userInfo: self.userInfo)
                        
                        let vc = RegStep4Controller()
                        vc.userInfo = self.userInfo
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else
                    {
                        ToastView.appearance().font = self.font14
                        ToastView.appearance().bottomOffsetPortrait = 100
                        let detail = json["detail"] as? String ?? ""
                        Toast(text: detail).show()
                    }
                }
                else
                {
                    ToastView.appearance().font = self.font14
                    ToastView.appearance().bottomOffsetPortrait = 100
                    Toast(text: "服务器出错，请重新尝试。").show()
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
