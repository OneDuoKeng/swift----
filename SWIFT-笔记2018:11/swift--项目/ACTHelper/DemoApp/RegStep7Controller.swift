//
//  RegStep7Controller.swift
//  DemoApp
//
//  Created by Jerry on 2017/3/31.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import Toaster
import PKHUD

class RegStep7Controller: BaseLoginRegViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var userInfo : UserInfo!
    var mainArea : UIView!
    var footArea : UIView!
    var inputArea : UIScrollView!
    var submit : RegButton!
    var titleSummary : UILabel!
    
    var splitLine : UIView!
    
    var checkNotTested : CustomCheckBox!
    var checkTested : CustomCheckBox!
    var scoreViewACT : ACTScoreInputView!
    var scoreViewSAT : SATScoreInputView!
    var scoreViewACTFrame : CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.backBt.isHidden = true
        
        mainArea = UIView(frame: CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 350))
        self.view.addSubview(mainArea)
        
        titleSummary = UILabel(frame: CGRect(x: 20, y: 0, width: self.view.frame.size.width - 40, height: 20))
        titleSummary.font = UIFont.boldSystemFont(ofSize: 14)
        titleSummary.textColor = UIColor.white
        titleSummary.text = "学习概况"
        mainArea.addSubview(titleSummary)
        
        checkNotTested = CustomCheckBox(frame: CGRect(x: 20, y: 124, width: width40, height: 45))
        checkNotTested.setTitle(title: "未参加过考试")
        let guesture = UITapGestureRecognizer(target: self, action: #selector(RegStep7Controller.selectNotTested(_:)))
        checkNotTested.addGestureRecognizer(guesture)
        self.view.addSubview(checkNotTested)
        
        checkTested = CustomCheckBox(frame: CGRect(x: 20, y: 179, width: width40, height: 45))
        checkTested.setTitle(title: "参加过考试")
        let guesture2 = UITapGestureRecognizer(target: self, action: #selector(RegStep7Controller.selectTested(_:)))
        checkTested.addGestureRecognizer(guesture2)
        self.view.addSubview(checkTested)
        
        splitLine = UIView(frame: CGRect(x: 0, y: 244, width: self.view.frame.size.width, height: 1))
        splitLine.backgroundColor = UIColor(red: 230.0/255, green: 230.0/255, blue: 230.0/255, alpha: 0.5)
        splitLine.isHidden = true
        self.view.addSubview(splitLine)
        
        footArea = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - 60, width: self.view.frame.size.width, height: 60))
        self.view.addSubview(footArea)
        
        let posX3 = self.view.frame.size.width - 90 - 20
        submit = RegButton(frame: CGRect(x: posX3, y: 0, width: 90, height: 37))
        submit.bt.setTitle("完成", for: .disabled)
        submit.bt.setTitle("完成", for: .normal)
        submit.bt.addTarget(self, action: #selector(RegStep7Controller.submit(_:)), for: .touchUpInside)
        footArea.addSubview(submit)
        
        let height = self.view.frame.size.height - 245 - 60
        inputArea = UIScrollView(frame: CGRect(x: 0, y: 245, width: Int(self.view.frame.size.width), height: Int(height)))
        inputArea.isHidden = true
        self.view.addSubview(inputArea)
        
        if(self.userInfo.myKeMu == .ACT)
        {
            scoreViewACTFrame = CGRect(x: 0, y: 1, width: Int(self.view.frame.size.width), height: 308)
            scoreViewACT = ACTScoreInputView(frame: scoreViewACTFrame)
            scoreViewACT.buildUIWithController(controller: self)
            inputArea.contentSize = CGSize(width: self.view.frame.size.width, height: 320)
            inputArea.addSubview(scoreViewACT)
        }
        else if(self.userInfo.myKeMu == .SAT)
        {
            scoreViewSAT = SATScoreInputView(frame: CGRect(x: 0, y: 1, width: Int(self.view.frame.size.width), height: 188))
            scoreViewSAT.buildUIWithController(controller: self)
            inputArea.contentSize = CGSize(width: self.view.frame.size.width, height: 200)
            inputArea.addSubview(scoreViewSAT)
        }
    }
    
    // MARK:
    // MARK:checkForm
    override func checkForm()
    {
        if self.checkNotTested.checkIcon.isHidden == false
        {
            self.submit.active()
        }
        else if self.checkTested.checkIcon.isHidden == false
        {
            if(self.userInfo.myKeMu == .ACT)
            {
                var isPass = true
                for i in self.scoreViewACT.scores
                {
                    if i == 0
                    {
                        isPass = false
                        break
                    }
                }
                if isPass
                {
                    self.submit.active()
                }
                else
                {
                    self.submit.deActive()
                }
            }
            else if(self.userInfo.myKeMu == .SAT)
            {
                var isPass = true
                for i in self.scoreViewSAT.scores
                {
                    if i == 0
                    {
                        isPass = false
                        break
                    }
                }
                if isPass
                {
                    self.submit.active()
                }
                else
                {
                    self.submit.deActive()
                }
            }
            
        }
        else
        {
            self.submit.deActive()
        }
    }
    
    func submit(_ sender : UIButton)
    {
        if(self.userInfo.isTested)
        {
            if(self.userInfo.myKeMu == .ACT)
            {
                var scores = self.scoreViewACT.scores
                self.userInfo.current_score = scores[0]
                self.userInfo.english = scores[1]
                self.userInfo.math = scores[2]
                self.userInfo.reading = scores[3]
                self.userInfo.science = scores[4]
                self.userInfo.exam_type = 0
            }
            else if(self.userInfo.myKeMu == .SAT)
            {
                var scores = self.scoreViewSAT.scores
                self.userInfo.reading = scores[0]
                self.userInfo.math = scores[1]
                self.userInfo.writing = scores[2]
                self.userInfo.exam_type = 1
            }
        }
        
        let url = "\(self.baseUrl)iOS/set_scores.json"
        let parameters = ["exam_type": self.userInfo.exam_type,
                          "current_score": self.userInfo.current_score,
                          "english": self.userInfo.english,
                          "math": self.userInfo.math,
                          "reading": self.userInfo.reading,
                          "science": self.userInfo.science,
                          "writing": self.userInfo.writing
                          ]
        
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
                        DataUtil.setCrtUser(userInfo: self.userInfo)
                        DataUtil.setLogined()
                        
                        let vc = ControllerUtil.getTabController()
                        UIApplication.shared.delegate?.window??.rootViewController = vc
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
    
    func selectNotTested(_ gusture:UITapGestureRecognizer)
    {
        self.userInfo.isTested = false
        self.checkNotTested.active()
        self.checkTested.deActive()
        checkForm()
        
        self.splitLine.isHidden = true
        self.inputArea.isHidden = true
    }
    
    func selectTested(_ gusture:UITapGestureRecognizer)
    {
        self.userInfo.isTested = true
        self.checkNotTested.deActive()
        self.checkTested.active()
        checkForm()
        
        self.splitLine.isHidden = false
        self.inputArea.isHidden = false
    }
    
    override func hideKeyboard()
    {
        self.view.endEditing(true)
        if(self.userInfo.myKeMu == .ACT)
        {
            self.scoreViewACT.hidePicker()
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
