//
//  RegButtonCount.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/24.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire
import Toaster

class SettingButtonCount: UIView {
    
    var baseNum : UInt = 60
    var bt : UIButton!
    var baseUrl : String = ""
    var phone : String = ""
    var willBeFocusedTextField : UITextField? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let btFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        bt = UIButton(frame: btFrame)
        bt.titleLabel?.font = UIFont(name: "PingFang SC", size: 14)!
        bt.setTitleColor(.white, for: .normal)
        bt.setTitleColor(UIColor(red: 74.0/255, green: 144.0/255, blue: 226.0/255, alpha: 1.0), for: .normal)
        bt.setTitleColor(UIColor(red: 230.0/255, green: 230.0/255, blue: 230.0/255, alpha: 1.0), for: .disabled)
        bt.setTitle("获取验证码", for: .normal)
        bt.backgroundColor = .clear
        
        bt.addTarget(self, action: #selector(SettingButtonCount.countTime), for: .touchUpInside)
        self.addSubview(bt)
        
        self.deActive()
    }
    
    func countTime()
    {
        if(phone != "")
        {
            self.deActive()
            baseNum = 60
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RegButtonCount.timerAction(_:)), userInfo: nil, repeats: true)
            
            //获取验证码
            let url = "\(self.baseUrl)iOS/authCode.json"
            
            HUD.show(.progress)
            Alamofire.request(url, method: .get).responseJSON
                { response in
                    
                    HUD.hide(animated: true)
                    
                    if let json = response.result.value as? [String: Any]
                    {
                        print("JSON: \(json)")
                        let code = json["code"] as? Int ?? 0
                        
                        if(code == 0)
                        {
                            if(self.willBeFocusedTextField != nil)
                            {
                                self.willBeFocusedTextField?.becomeFirstResponder()
                            }
                        }
                        else if(code == 10001)
                        {
                            ToastView.appearance().bottomOffsetPortrait = 100
                            Toast(text: "联系方式格式错误。").show()
                        }
                        else if(code == 4008)
                        {
                            ToastView.appearance().bottomOffsetPortrait = 100
                            Toast(text: "用户不存在。").show()
                        }
                        else if(code == 4005)
                        {
                            ToastView.appearance().bottomOffsetPortrait = 100
                            Toast(text: "用户存在。").show()
                        }
                        else if(code == 4003)
                        {
                            ToastView.appearance().bottomOffsetPortrait = 100
                            Toast(text: "用户名空。").show()
                        }
                    }
                    else
                    {
                        ToastView.appearance().bottomOffsetPortrait = 100
                        Toast(text: "获取验证码失败，请重新尝试！").show()
                    }
            }
        }
    }
    
    func timerAction(_ timer:Timer)
    {
        baseNum -= 1
        self.bt.setTitle("获取 \(baseNum)S", for: .normal)
        
        if(baseNum <= 0)
        {
            baseNum = 60
            self.active()
            self.bt.setTitle("重新获取", for: .normal)
            timer.invalidate()
        }
    }
    
    func active()
    {
        self.bt.isEnabled = true
    }
    
    func deActive()
    {
        self.bt.isEnabled = false
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
