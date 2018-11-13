//
//  SATScoreInputViewBlack.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/24.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import Toaster
import PKHUD

class SATScoreInputViewBlack: UIView, UITextFieldDelegate {
    
    weak var controller : PersonalInfoViewController!
    var crtTextField : UITextField!
    var scores = [0, 0, 0]
    var crtItem = 0
    var originFrame : CGRect!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.originFrame = frame
    }
    
    func buildUIWithController(controller : PersonalInfoViewController)
    {
        self.controller = controller
        
        let labels = ["阅读和语法总分","数学总分","写作总分"]
        
        let width = Int(frame.size.width) - 40
        
        for i in 0 ... 2
        {
            let label = UILabel(frame: CGRect(x: 20, y: 20 + 60*i, width: width, height: 20))
            label.textColor = controller.fontColorDarkGray
            label.font = controller.font14
            label.text = labels[i]
            self.addSubview(label)
            
            let posX = Int(frame.size.width) - 20 - 100
            let textField = UITextField(frame: CGRect(x: posX, y: 10 + 60*i, width: 100, height: 40))
            textField.tag = i + 1
            textField.font = controller.font14
            textField.textColor = controller.fontColorDarkGray
            textField.delegate = self
            textField.keyboardType = .numberPad
            let attributes = [NSFontAttributeName: self.controller.font14, NSForegroundColorAttributeName: self.controller.fontColorRed]
            textField.attributedPlaceholder = NSAttributedString(string:"点击填写", attributes: attributes)
            textField.textAlignment = .right
            self.addSubview(textField)
            
            let line = UIView(frame: CGRect(x: 20, y: 60 + 60*i, width: width, height: 1))
            line.backgroundColor = controller.fontColorLightGray
            self.addSubview(line)
        }
        
    }
    
    func setScores(scores : Array<Int>)
    {
        self.scores = scores
        for i in 0 ... 2
        {
            let bt = self.viewWithTag(i+1) as! UITextField
            bt.text = "\(scores[i])"
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.crtTextField = textField
        
        if(self.frame.size.width == 320)
        {
            if(self.crtTextField.tag >= 2)
            {
                let distance = (self.crtTextField.tag - 1) * 60 - 20
                UIView.beginAnimations("scroll", context: nil)
                self.controller.inputArea?.frame = CGRect(x: 0, y: Int(self.controller.inputAreaFrame.origin.y) - distance, width: Int(self.controller.inputAreaFrame.size.width), height: Int(self.controller.inputAreaFrame.size.height))
                UIView.commitAnimations()
            }
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        let value = textField.text
        let index = textField.tag - 1
        if value == ""
        {
            self.scores[index] = 0
        }
        else
        {
            self.scores[index] = Int(value!)!
        }
        
        if(self.frame.size.width == 320)
        {
            UIView.beginAnimations("scroll", context: nil)
            self.controller.inputArea?.frame = self.controller.inputAreaFrame
            UIView.commitAnimations()
        }
        
        
        //提交至服务器
        let scoreTypes = ["reading","math","writing"]
        let scoreType = scoreTypes[index]
        let parameters = ["exam_type": 1, scoreType:self.scores[index]]
        let url = "\(self.controller.baseUrl)iOS/myInfo.json"
        
        HUD.show(.progress)
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON
            { response in
                
                HUD.hide(animated: true)
                print(response)
                
                if let json = response.result.value as? [String: Any]
                {
                    print("JSON: \(json)")
                    let code = json["code"] as? Int ?? 0
                    let detail = json["detail"] as? String ?? ""
                    
                    ToastView.appearance().bottomOffsetPortrait = 80
                    if(code == 0)
                    {
                        let userInfo = DataUtil.getCrtUser()
                        userInfo.setSATScore(num: index, score: self.scores[index])
                        DataUtil.setCrtUser(userInfo: userInfo)
                        
                        ToastView.appearance().font = self.controller.font14
                        
                        let labels = ["阅读和语法总分","数学总分","写作总分"]
                        let tip = "\(labels[index])设置成功！"
                        Toast(text: tip, duration: Delay.short).show()
                    }
                    else
                    {
                        Toast(text: detail).show()
                    }
                }
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var maxNum = 800
        if(textField.tag == 3)
        {
            //maxNum = 24
            maxNum = 800
        }
        
        let txt = textField.text
        let str = "\(txt!)\(string)"
        let socre = Int(str)
        if socre! <= maxNum
        {
            return true
        }
        else
        {
            return false
        }
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
