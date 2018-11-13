//
//  FeedBackViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/5/2.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
import Toaster

class FeedBackViewController: BaseViewController {

    var topView : UIView!
    var topViewFrame : CGRect!
    var lblTitle : UILabel!
    var formView : FeedbackRow!
    var footArea : UIView!
    var footAreaFrame : CGRect!
    var btSubmit : RegButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        lblTitle.text = "向我们反馈"
        lblTitle.font = self.font24
        lblTitle.textColor = self.fontColorDarkGray
        topView.addSubview(lblTitle)
        
        var posY = 26
        if(self.view.frame.size.width >= 375)
        {
            posY = 16
        }
        let subTitle = UILabel(frame: CGRect(x: 20, y: posY, width: self.width40, height: 120))
        subTitle.numberOfLines = 5
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        
        let attributes = [NSFontAttributeName: self.font14, NSForegroundColorAttributeName: self.fontColorDarkGray, NSParagraphStyleAttributeName: paragraphStyle]
        subTitle.attributedText = NSAttributedString(string: "我们想了解您喜欢哪些功能，对哪些功能存在不满，以及您认为我们可以在哪些方面可以做得更好，我们会非常耐心的倾听您的每一次反馈。", attributes: attributes)
        topView.addSubview(subTitle)
        
        var posY2 = 146
        if(self.view.frame.size.width == 320)
        {
            posY2 = 156
        }
        formView = FeedbackRow(frame: CGRect(x: 0, y: posY2, width: Int(self.view.frame.size.width), height: 80))
        formView.controller = self
        topView.addSubview(formView)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FeedBackViewController.hideKeyboard)))
        
        let posY3 = self.view.frame.size.height - 74
        footAreaFrame = CGRect(x: 0, y: posY3, width: self.view.frame.size.width, height: 73)
        footArea = UIView(frame: footAreaFrame)
        self.view.addSubview(footArea)
        let split = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1))
        split.backgroundColor = self.fontColorLightGray
        footArea.addSubview(split)
        
        btSubmit = RegButton(frame: CGRect(x: 20, y: 18, width: self.width40, height: 38))
        btSubmit.bt.setTitle("提交反馈", for: .disabled)
        btSubmit.bt.setTitle("提交反馈", for: .normal)
        btSubmit.bt.addTarget(self, action: #selector(FeedBackViewController.submit(_:)), for: .touchUpInside)
        footArea.addSubview(btSubmit)

        
        self.formView.inputField.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(FeedBackViewController.keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(FeedBackViewController.keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.hideTabBar()
    }
    
    // MARK:
    // MARK:keyboardWillShow
    func keyboardWillShow(_ notification: Notification?)
    {
        var keyboardH = Int(self.getKeyboardHeight())
        if(self.view.frame.width == 414)
        {
            keyboardH += 20
        }
        else if(self.view.frame.width == 375)
        {
            keyboardH += 5
        }
        else if(self.view.frame.width == 320)
        {
            keyboardH -= 12
        }
        
        UIView.beginAnimations("keyboardWillShow", context: nil)
        
        UIView.setAnimationDuration(0.2)
        let frame = CGRect(x: 0, y: Int(footAreaFrame.origin.y) - keyboardH, width: Int(footAreaFrame.size.width), height: Int(footAreaFrame.size.height))
        self.footArea.frame = frame
        
        if(self.view.frame.width == 320)
        {
            self.lblTitle.layer.opacity = 0
            self.topView.frame = CGRect(x: 0, y: 21, width: Int(self.topViewFrame.size.width), height: Int(self.topViewFrame.size.height))
        }
        
        UIView.commitAnimations()
    }
    
    
    func keyboardWillHide(_ notification: Notification?)
    {
        UIView.beginAnimations("keyboardWillShow", context: nil)
        UIView.setAnimationDuration(0.3)
        self.footArea.frame = footAreaFrame
        
        if(self.view.frame.width == 320)
        {
            self.lblTitle.layer.opacity = 1
            self.topView.frame = topViewFrame
        }
        
        UIView.commitAnimations()
    }
    
    func hideKeyboard()
    {
        self.view.endEditing(true)
    }
    
    func checkForm()
    {
        if(self.formView.isPass)
        {
            self.btSubmit.active()
        }
        else
        {
            self.btSubmit.deActive()
        }
        
    }
    
    func submit(_ sender : UIButton)
    {
        let url = "\(self.baseUrl)iOS/feedback.json"
        let parameters = ["content": "fazhan@coolketang.com"]
        
        HUD.show(.progress)
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON
            { response in
                
                HUD.hide(animated: true)
                print(response.result.value)
                if let json = response.result.value as? [String: Any]
                {
                    print("JSON: \(json)")
                    let code = json["code"] as? Int ?? 0
                    
                    if(code == 0)
                    {
                        self.navigationController?.popViewController(animated: true)
                        ToastView.appearance().bottomOffsetPortrait = 100
                        Toast(text: "提交成功，非常感谢！").show()
                    }
                    else
                    {
                        ToastView.appearance().bottomOffsetPortrait = 100
                        Toast(text: "提交失败，请重新尝试！").show()
                    }
                }
                
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
