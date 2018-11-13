//
//  RegStep8Controller.swift
//  DemoApp
//
//  Created by Jerry on 2017/3/31.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class RegStep8Controller: BaseViewController {

    var userInfo : UserInfo!
    var mainArea : UIView!
    var submit : RegButton!
    var titleDone : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.backBt.isHidden = true
        
        mainArea = UIView(frame: CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 350))
        self.view.addSubview(mainArea)
        
        titleDone = UILabel(frame: CGRect(x: 20, y: 0, width: width40, height: 20))
        titleDone.font = UIFont.boldSystemFont(ofSize: 24)
        titleDone.textColor = UIColor.white
        titleDone.text = "完成注册"
        mainArea.addSubview(titleDone)
        
        let subTitle = UILabel(frame: CGRect(x: 20, y: 30, width: width40, height: 20))
        subTitle.font = UIFont.boldSystemFont(ofSize: 14)
        subTitle.textColor = UIColor.white
        subTitle.text = "欢迎您成为彩虹学院的一员。"
        mainArea.addSubview(subTitle)
        
        submit = RegButton(frame: CGRect(x: 20, y: 180, width: width40, height: 37))
        submit.bt.setTitle("点击登录", for: .disabled)
        submit.bt.setTitle("点击登录", for: .normal)
        submit.bt.addTarget(self, action: #selector(RegStep8Controller.submit(_:)), for: .touchUpInside)
        submit.active()
        self.view.addSubview(submit)
 
    }
    
    func submit(_ sender : UIButton)
    {
        DataUtil.setVisitorLogin(value: false)
        
        let vc = ControllerUtil.getTabController()
        UIApplication.shared.delegate?.window??.rootViewController = vc
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
