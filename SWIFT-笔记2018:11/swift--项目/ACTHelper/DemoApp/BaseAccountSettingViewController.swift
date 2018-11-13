//
//  BaseAccountSettingViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/5/2.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class BaseAccountSettingViewController: BaseViewController {

    var focusedFieldType = ""
    var topView : UIView!
    var topViewFrame : CGRect!
    var lblTitle : UILabel!
    var footArea : UIView!
    var footAreaFrame : CGRect!
    var btSubmit : RegButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.layer.sublayers?[0].removeFromSuperlayer()
        self.view.backgroundColor = .white
        
        let image = UIImage(named: "LeftArrowDrakGray")
        self.backBt.setImage(image, for: .normal)
        
        topViewFrame = CGRect(x: 0, y: 74, width: self.view.frame.size.width, height: 300)
        topView = UIView(frame: topViewFrame)
        self.view.addSubview(topView)
        
        lblTitle = UILabel(frame: CGRect(x: 20, y: 0, width: 150, height: 24))
        lblTitle.text = ""
        lblTitle.font = self.font24
        lblTitle.textColor = self.fontColorDarkGray
        topView.addSubview(lblTitle)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BaseAccountSettingViewController.hideKeyboard)))
        
        let posY3 = self.view.frame.size.height - 74
        footAreaFrame = CGRect(x: 0, y: posY3, width: self.view.frame.size.width, height: 73)
        footArea = UIView(frame: footAreaFrame)
        footArea.backgroundColor = .white
        self.view.addSubview(footArea)
        let split = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1))
        split.backgroundColor = self.fontColorLightGray
        footArea.addSubview(split)
        
        btSubmit = RegButton(frame: CGRect(x: 20, y: 18, width: self.width40, height: 38))
        btSubmit.bt.setTitle("确认提交", for: .disabled)
        btSubmit.bt.setTitle("确认提交", for: .normal)
        footArea.addSubview(btSubmit)
    }

    func hideKeyboard()
    {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkForm()
    {
        
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
