//
//  AccountSettingsViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/5/2.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
import Toaster

class AccountSettingsViewController: BaseAccountSettingViewController {
    
    var inputPhone : UILabel!
    var inputPassword : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lblTitle.text = "账号设置"
        
        let lblPhone = UILabel(frame: CGRect(x: 20, y: 146, width: 70, height: 17))
        lblPhone.text = "绑定手机"
        lblPhone.font = self.font17
        lblPhone.textColor = self.fontColorDarkGray
        self.view.addSubview(lblPhone)
        
        let lblPassword = UILabel(frame: CGRect(x: 20, y: 251, width: 70, height: 17))
        lblPassword.text = "密码设置"
        lblPassword.font = self.font17
        lblPassword.textColor = self.fontColorDarkGray
        self.view.addSubview(lblPassword)
        
        inputPhone = UILabel(frame: CGRect(x: 20, y: 183, width: 200, height: 17))
        inputPhone.font = self.font14
        inputPhone.textColor = self.fontColorDarkGray
        self.view.addSubview(inputPhone)
        
        inputPassword = UILabel(frame: CGRect(x: 20, y: 288, width: 93, height: 17))
        inputPassword.text = "******"
        inputPassword.font = self.font14
        inputPassword.textColor = self.fontColorDarkGray
        self.view.addSubview(inputPassword)
        
        let posX = self.view.frame.size.width - 20 - 40
        let btPhone = UIButton(frame: CGRect(x:posX , y: 171, width: 40, height: 38))
        btPhone.setTitle("更换", for: .normal)
        btPhone.titleLabel?.font = self.font14
        btPhone.titleLabel?.textColor = self.fontColorBlue
        btPhone.setTitleColor(self.fontColorBlue, for: .normal)
        btPhone.addTarget(self, action: #selector(AccountSettingsViewController.changePhone(_:)), for: .touchUpInside)
        self.view.addSubview(btPhone)
        
        let btPassword = UIButton(frame: CGRect(x:posX , y: 276, width: 40, height: 38))
        btPassword.setTitle("更换", for: .normal)
        btPassword.titleLabel?.font = self.font14
        btPassword.titleLabel?.textColor = self.fontColorBlue
        btPassword.setTitleColor(self.fontColorBlue, for: .normal)
        btPassword.addTarget(self, action: #selector(AccountSettingsViewController.changePassword(_:)), for: .touchUpInside)
        self.view.addSubview(btPassword)
        
        let split1 = UIView(frame: CGRect(x: 20, y: 220, width: self.width40, height: 1))
        split1.backgroundColor = self.fontColorLightGray
        self.view.addSubview(split1)
        
        let split2 = UIView(frame: CGRect(x: 20, y: 325, width: self.width40, height: 1))
        split2.backgroundColor = self.fontColorLightGray
        self.view.addSubview(split2)
        
        self.btSubmit.active()
        self.btSubmit.bt.setTitle("账号登出", for: .disabled)
        self.btSubmit.bt.setTitle("账号登出", for: .normal)
        self.btSubmit.bt.addTarget(self, action: #selector(AccountSettingsViewController.logOut(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.hideTabBar()
        
        let userInfo = DataUtil.getCrtUser()
        if(userInfo.phone == "")
        {
            inputPhone.text = "尚未绑定手机"
        }
        else
        {
            inputPhone.text = userInfo.phone
        }
    }
    
    func changePhone(_ sender : UIButton)
    {
        let vc = ChangePhoneViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func changePassword(_ sender : UIButton)
    {
        
        let vc = ChangePasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func logOut(_ sender : UIButton)
    {
        let url = "\(self.baseUrl)iOS/logout.json"
        
        HUD.show(.progress)
        Alamofire.request(url, method: .get).responseJSON
            { response in
                
                HUD.hide(animated: true)
                print(response)
                if let json = response.result.value as? [String: Any]
                {
                    print("JSON: \(json)")
                    let code = json["code"] as? Int ?? 0
                    
                    if(code == 0)
                    {
                        DataUtil.setLoginOut()
                        
                        let storyBoard = UIStoryboard(name: "RegLogin", bundle: nil)
                        let vc = storyBoard.instantiateInitialViewController()
                        let navigationController = UINavigationController(rootViewController: vc!)
                        UIApplication.shared.delegate?.window??.rootViewController = navigationController
                    }
                    else
                    {
                        ToastView.appearance().bottomOffsetPortrait = 100
                        Toast(text: "登出失败，请重新尝试！").show()
                    }
                }
                else
                {
                    ToastView.appearance().bottomOffsetPortrait = 150
                    Toast(text: "操作失败，请重新尝试。").show()
                }
        }
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
