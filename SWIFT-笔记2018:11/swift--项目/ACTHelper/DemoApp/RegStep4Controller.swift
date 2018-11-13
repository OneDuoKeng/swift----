//
//  RegStep4Controller.swift
//  DemoApp
//
//  Created by Jerry on 2017/3/31.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class RegStep4Controller: BaseViewController {

    var userInfo : UserInfo!
    var mainArea : UIView!
    var footArea : UIView!
    var submit : RegButton!
    var titleDone : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.backBt.isHidden = true
        
        mainArea = UIView(frame: CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 350))
        self.view.addSubview(mainArea)
        
        titleDone = UILabel(frame: CGRect(x: 20, y: 0, width: self.view.frame.size.width - 40, height: 20))
        titleDone.font = UIFont.boldSystemFont(ofSize: 24)
        titleDone.textColor = UIColor.white
        titleDone.text = "完成注册"
        mainArea.addSubview(titleDone)
        
        let subTitle = UILabel(frame: CGRect(x: 20, y: 30, width: self.view.frame.size.width - 40, height: 20))
        subTitle.font = UIFont.boldSystemFont(ofSize: 14)
        subTitle.textColor = UIColor.white
        subTitle.text = "欢迎您成为彩虹学院的一员。"
        mainArea.addSubview(subTitle)
        
        var dis : Int = 60
        if(self.view.frame.size.width >= 375)
        {
            dis += 60
        }
        
        let line = UIView(frame: CGRect(x: 20, y: 218 + dis, width: Int(self.view.frame.size.width-40), height: 1))
        line.backgroundColor = UIColor.white
        self.view.addSubview(line)
        
        footArea = UIView(frame: CGRect(x: 0, y: Int(line.frame.origin.y) + 20, width: Int(self.view.frame.size.width), height: 160))
        self.view.addSubview(footArea)
        
        let bigTitle = UILabel(frame: CGRect(x: 20, y: 0, width: line.frame.size.width, height: 20))
        bigTitle.text = "接下来，完善您的信息"
        bigTitle.textColor = .white
        bigTitle.font = self.font24
        footArea.addSubview(bigTitle)
        
        let subTitle2 = UILabel(frame: CGRect(x: 20, y: 30, width: line.frame.size.width, height: 20))
        subTitle2.text = "完善个人信息，能够获得个性化的学习帮助。"
        subTitle2.textColor = .white
        subTitle2.font = self.font14
        footArea.addSubview(subTitle2)
        
        submit = RegButton(frame: CGRect(x: 20, y: 80, width: line.frame.size.width, height: 37))
        submit.bt.setTitle("完善您的信息", for: .disabled)
        submit.bt.setTitle("完善您的信息", for: .normal)
        submit.bt.addTarget(self, action: #selector(RegStep4Controller.submit(_:)), for: .touchUpInside)
        submit.active()
        footArea.addSubview(submit)
 
    }
    
    func submit(_ sender : UIButton)
    {
        let vc = RegStep5Controller()
        vc.userInfo = self.userInfo
        self.navigationController?.pushViewController(vc, animated: true)
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
