//
//  LoginByPhoneController.swift
//  DemoApp
//
//  Created by Jerry on 2017/3/31.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
import Toaster

enum LoginType {
    case Mainland
    case Overseas
}

class LoginController: BaseLoginRegViewController {

    var showToastAfterChangingPasword : Bool = false
    var shouldHideBackButton : Bool = false
    var loginType : LoginType = .Mainland
    var switchMainland : UIButton!
    var switchOverseas : UIButton!
    var mainlandLoginArea : UIView!
    var overseasLoginArea : UIView!
    var footArea : UIView!
    var rowTel : FormRow!
    var rowPwd : FormRow!
    var rowEmail : FormRow!
    var rowPwd2 : FormRow!
    var submit : RegButton!
    var titleMainland : UILabel!
    var titleHaiWai : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.dismissBt.isHidden = true
        
        if self.shouldHideBackButton
        {
            self.backBt.isHidden = true
        }
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginController.hideKeyboard)))
        
        let posX = self.view.frame.size.width - 143 - 20
        let switchFrame = CGRect(x:posX, y:21, width:143, height:44)
        
        switchOverseas = UIButton(frame: switchFrame)
        switchOverseas.titleLabel?.font = self.font14
        switchOverseas.setTitle("港澳台及海外用户登录", for: .normal)
        switchOverseas.addTarget(self, action: #selector(LoginController.switchToHaiWai(_:)), for: .touchUpInside)
        self.view.addSubview(switchOverseas)
        
        let posX2 = self.view.frame.size.width - 115 - 20
        let switchFrame2 = CGRect(x:posX2, y:21, width:115, height:44)
        switchMainland = UIButton(frame: switchFrame2)
        switchMainland.titleLabel?.font = self.font14
        switchMainland.setTitle("中国大陆用户登录", for: .normal)
        switchMainland.addTarget(self, action: #selector(LoginController.switchToDaLu(_:)), for: .touchUpInside)
        switchMainland.isHidden = true
        self.view.addSubview(switchMainland)
        
        mainlandLoginArea = UIView(frame: CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 350))
        self.view.addSubview(mainlandLoginArea)
        
        titleMainland = UILabel(frame: CGRect(x: 20, y: 0, width: 220, height: 20))
        titleMainland.font = UIFont.boldSystemFont(ofSize: 24)
        titleMainland.textColor = UIColor.white
        titleMainland.text = "中国大陆用户登录"
        mainlandLoginArea.addSubview(titleMainland)
        
        rowTel = FormRow(frame: CGRect(x: 0, y: 70, width: Int(self.view.frame.size.width), height: 90))
        rowTel.setValueType(type: FieldType.Tel)
        rowTel.controller = self
        mainlandLoginArea.addSubview(rowTel)
        
        rowPwd = FormRow(frame: CGRect(x: 0, y: 160, width: Int(self.view.frame.size.width), height: 90))
        rowPwd.setValueType(type: FieldType.Password)
        rowPwd.controller = self
        mainlandLoginArea.addSubview(rowPwd)
        
        overseasLoginArea = UIView(frame: CGRect(x: self.view.frame.size.width, y: 80, width: self.view.frame.size.width, height: 350))
        overseasLoginArea.layer.opacity = 0.0
        self.view.addSubview(overseasLoginArea)
        
        titleHaiWai = UILabel(frame: CGRect(x: 20, y: 0, width: 280, height: 20))
        titleHaiWai.font = UIFont.boldSystemFont(ofSize: 24)
        titleHaiWai.textColor = UIColor.white
        titleHaiWai.text = "港澳台及海外用户登录"
        overseasLoginArea.addSubview(titleHaiWai)
        
        rowEmail = FormRow(frame: CGRect(x: 0, y: 70, width: Int(self.view.frame.size.width), height: 90))
        rowEmail.setValueType(type: FieldType.Email)
        rowEmail.controller = self
        overseasLoginArea.addSubview(rowEmail)
        
        rowPwd2 = FormRow(frame: CGRect(x: 0, y: 160, width: Int(self.view.frame.size.width), height: 90))
        rowPwd2.setValueType(type: FieldType.Password)
        rowPwd2.controller = self
        overseasLoginArea.addSubview(rowPwd2)
        
        footArea = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - 60, width: self.view.frame.size.width, height: 60))
        self.view.addSubview(footArea)
        
        let posX3 = self.view.frame.size.width - 90 - 20
        submit = RegButton(frame: CGRect(x: posX3, y: 0, width: 90, height: 37))
        submit.bt.setTitle("立即登陆", for: .disabled)
        submit.bt.setTitle("立即登陆", for: .normal)
        submit.bt.addTarget(self, action: #selector(LoginController.submit(_:)), for: .touchUpInside)
        footArea.addSubview(submit)
        
        if self.loginType == .Overseas
        {
            self.switchToHaiWai(switchOverseas)
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(LoginController.keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(LoginController.keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
 
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        if self.showToastAfterChangingPasword
        {
            ToastView.appearance().font = self.font14
            ToastView.appearance().bottomOffsetPortrait = 100
            Toast(text: "密码修改成功，请重新登陆！", duration:Delay.long).show()
            self.showToastAfterChangingPasword = false
        }
        else
        {
            if self.loginType == .Mainland
            {
                self.rowTel.inputField.becomeFirstResponder()
            }
            else
            {
                self.rowEmail.inputField.becomeFirstResponder()
            }
        }
    }
    
    // MARK:
    // MARK:switchToHaiWai
    func switchToHaiWai(_ sender:UIButton)
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
    
    func switchToDaLu(_ sender:UIButton)
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
        
        UIView.setAnimationDuration(0.3)
        self.footArea.frame = frame
        
        if(self.view.frame.width == 320)
        {
            if(self.loginType == .Mainland)
            {
                self.titleMainland.layer.opacity = 0
                self.mainlandLoginArea.frame = CGRect(x: 0, y: 80 - 80, width: self.view.frame.size.width, height: 350)
            }
            else
            {
                self.titleHaiWai.layer.opacity = 0
                self.overseasLoginArea.frame = CGRect(x: 0, y: 80 - 80, width: self.view.frame.size.width, height: 350)
            }
        }
        
        UIView.commitAnimations()
    }
    
    
    func keyboardWillHide(_ notification: Notification?)
    {
        let frame = CGRect(x: 0, y: Int(self.view.frame.size.height) - 60, width: Int(self.view.frame.size.width), height: 60)
        
        UIView.beginAnimations("keyboardWillShow", context: nil)
        UIView.setAnimationDuration(0.3)
        self.footArea.frame = frame
        
        if(self.view.frame.width == 320)
        {
            if(self.loginType == .Mainland)
            {
                self.titleMainland.layer.opacity = 1
                self.mainlandLoginArea.frame = CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 350)
            }
            else
            {
                self.titleHaiWai.layer.opacity = 1
                self.overseasLoginArea.frame = CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 350)
            }
        }
        
        UIView.commitAnimations()
    }
    
    // MARK:
    // MARK:checkForm
    override func checkForm()
    {
        if(self.loginType == .Mainland)
        {
            if rowTel.isPass && rowPwd.isPass
            {
                self.submit.active()
            }
            else
            {
                self.submit.deActive()
            }
        }
        else if(self.loginType == .Overseas)
        {
            if rowEmail.isPass && rowPwd2.isPass
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
            rowPwd.isPass = false
            
            _ = rowTel.checkValue()
            _ = rowPwd.checkValue()
            
            if rowTel.isPass && rowPwd.isPass
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
            rowPwd2.isPass = false
            
            _ = rowEmail.checkValue()
            _ = rowPwd2.checkValue()
            
            if rowEmail.isPass && rowPwd2.isPass
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
        var password : String
        
        if(self.loginType == .Mainland)
        {
            password = AESUtil.encrypt(encryptData: rowPwd.getValue())
            parameters = ["phone": rowTel.getValue(), "password" : password]
        }
        else
        {
            password = AESUtil.encrypt(encryptData: rowPwd2.getValue())
            parameters = ["email": rowEmail.getValue(), "password" : password]
        }
        
        let url = "\(self.baseUrl)iOS/login.json"
        
        self.hideKeyboard()
        
        HUD.show(.progress)
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON
            { response in
                debugPrint(response.result.value!)
                HUD.hide(animated: true)
                
                ToastView.appearance().font = self.font14
                if let json = response.result.value as? [String: Any]
                {
                    print("JSON: \(json)")
                    
                    let code = json["code"] as? Int ?? 0
                    if(code == 0)
                    {
                        let detail = json["detail"] as? [String: Any]
                        
                        let userInfo = UserInfo()
                        userInfo.birthday = detail?["birthday"] as? String ?? ""
                        userInfo.grade = detail?["grade"] as? Int ?? 0
                        userInfo.head_img = detail?["head_img"] as? String ?? ""
                        userInfo.id = detail!["id"] as? Int ?? 0
                        userInfo.nickname = detail?["nickname"] as? String ?? ""
                        userInfo.sex = detail?["sex"] as? Int ?? 0
                        userInfo.status = detail?["status"] as? Int ?? 0
                        userInfo.email = detail?["email"] as? String ?? ""
                        userInfo.phone = detail?["phone"] as? String ?? ""
                        userInfo.teacher = detail?["teacher"] as? String ?? ""
                        userInfo.password = password
                        
                        let scores = detail?["scores"] as? [String: Any]
                        userInfo.current_score = scores?["current_score"] as? Int ?? 0
                        userInfo.english = scores?["english"] as? Int ?? 0
                        userInfo.math = scores?["math"] as? Int ?? 0
                        userInfo.reading = scores?["reading"] as? Int ?? 0
                        userInfo.science = scores?["science"] as? Int ?? 0
                        userInfo.writing = scores?["writing"] as? Int ?? 0
                        
                        userInfo.expect_score = scores?["expect_score"] as? Int ?? 0
                        userInfo.expect_english = scores?["expect_english"] as? Int ?? 0
                        userInfo.expect_math = scores?["expect_math"] as? Int ?? 0
                        userInfo.expect_reading = scores?["expect_reading"] as? Int ?? 0
                        userInfo.expect_science = scores?["expect_science"] as? Int ?? 0
                        userInfo.expect_writing = scores?["expect_writing"] as? Int ?? 0
                        
                        if userInfo.exam_type == 0
                        {
                            userInfo.myKeMu = .ACT
                        }
                        else
                        {
                            userInfo.myKeMu = .SAT
                        }
                        
                        DataUtil.setCrtUser(userInfo: userInfo)
                        DataUtil.setLogined()
                        DataUtil.setVisitorLogin(value: false)
                        
                        let vc = ControllerUtil.getTabController()
                        UIApplication.shared.delegate?.window??.rootViewController = vc
                    }
                    else if(code == 4008)
                    {
                        ToastView.appearance().bottomOffsetPortrait = 100
                        Toast(text: "此用户不存在，请尝试其它账户！").show()
                    }
                    else if(code == 4010)
                    {
                        let detail = json["detail"] as? [String: Any]
                        let userId = detail?["user"] as? Int ?? 0
                        
                        let userInfo = UserInfo()
                        userInfo.id = userId
                        
                        if(self.loginType == .Mainland)
                        {
                            userInfo.isHaiWai = false
                            userInfo.phone = self.rowTel.getValue()
                        }
                        else
                        {
                            userInfo.isHaiWai = true
                            userInfo.email = self.rowEmail.getValue()
                        }
                        userInfo.password = password
                        
                        DataUtil.setCrtUser(userInfo: userInfo)
                        
                        let vc = RegStep4Controller()
                        vc.userInfo = userInfo
                        let navigationController = UINavigationController(rootViewController: vc)
                        UIApplication.shared.delegate?.window??.rootViewController = navigationController
                    }
                    
                }
                else
                {
                    ToastView.appearance().bottomOffsetPortrait = 100
                    Toast(text: "登陆失败，请重新尝试！").show()
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
