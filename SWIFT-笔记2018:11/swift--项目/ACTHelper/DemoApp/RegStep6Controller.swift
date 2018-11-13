//
//  RegStep5Controller.swift
//  DemoApp
//
//  Created by Jerry on 2017/3/31.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class RegStep6Controller: BaseLoginRegViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var userInfo : UserInfo!
    var mainArea : UIView!
    var footArea : UIView!
    var submit : RegButton!
    var titleSubject : UILabel!
    var checkAct : CustomCheckBox!
    var checkSat : CustomCheckBox!
    var mySubject : PaperType = .ACT
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.backBt.isHidden = true
        
        //中国大陆用户注册区
        mainArea = UIView(frame: CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 350))
        self.view.addSubview(mainArea)
        
        titleSubject = UILabel(frame: CGRect(x: 20, y: 0, width: self.view.frame.size.width - 40, height: 20))
        titleSubject.font = UIFont.boldSystemFont(ofSize: 14)
        titleSubject.textColor = UIColor.white
        titleSubject.text = "选择备考科目"
        mainArea.addSubview(titleSubject)
        
        checkAct = CustomCheckBox(frame: CGRect(x: 20, y: 124, width: width40, height: 45))
        checkAct.setTitle(title: "ACT")
        let guesture = UITapGestureRecognizer(target: self, action: #selector(RegStep6Controller.selecACT(_:)))
        checkAct.addGestureRecognizer(guesture)
        self.view.addSubview(checkAct)
        
        checkSat = CustomCheckBox(frame: CGRect(x: 20, y: 179, width: width40, height: 45))
        checkSat.setTitle(title: "SAT")
        let guesture2 = UITapGestureRecognizer(target: self, action: #selector(RegStep6Controller.selecSAT(_:)))
        checkSat.addGestureRecognizer(guesture2)
        self.view.addSubview(checkSat)
        
        footArea = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - 60, width: self.view.frame.size.width, height: 60))
        self.view.addSubview(footArea)
        
        let posX3 = self.view.frame.size.width - 90 - 20
        submit = RegButton(frame: CGRect(x: posX3, y: 0, width: 90, height: 37))
        submit.bt.setTitle("下一步", for: .disabled)
        submit.bt.setTitle("下一步", for: .normal)
        submit.bt.addTarget(self, action: #selector(RegStep6Controller.submit(_:)), for: .touchUpInside)
        footArea.addSubview(submit)
    }
    
    // MARK:
    // MARK:checkForm
    override func checkForm()
    {
        if checkAct.checkIcon.isHidden == false || checkSat.checkIcon.isHidden == false
        {
            self.submit.active()
        }
        else
        {
            self.submit.deActive()
        }
    }
    
    func submit(_ sender : UIButton)
    {
        self.userInfo.myKeMu = self.mySubject
        
        if(self.mySubject == .ACT)
        {
            self.userInfo.exam_type = 0
        }
        else
        {
            self.userInfo.exam_type = 1
        }
        
        let vc = RegStep7Controller()
        vc.userInfo = self.userInfo
        
        DataUtil.setCrtUser(userInfo: self.userInfo)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func selecACT(_ gusture:UITapGestureRecognizer)
    {
        self.mySubject = .ACT
        checkAct.active()
        checkSat.deActive()
        checkForm()
    }
    
    func selecSAT(_ gusture:UITapGestureRecognizer)
    {
        self.mySubject = .SAT
        checkAct.deActive()
        checkSat.active()
        checkForm()
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
