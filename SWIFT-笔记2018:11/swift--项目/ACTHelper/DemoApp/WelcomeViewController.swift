//
//  WelcomeViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/3/28.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.dismissBt.isHidden = true
        self.backBt.isHidden = true
        
        let viewH = self.view.frame.size.height
        let viewW = self.view.frame.size.width
        let bigTitle = UILabel(frame: CGRect(x: 0, y: viewH * 0.27, width: viewW, height: 20))
        bigTitle.text = "欢迎来到酷课堂"
        bigTitle.font = self.font24
        bigTitle.textAlignment = .center
        bigTitle.textColor = .white
        self.view.addSubview(bigTitle)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        paragraphStyle.alignment = .center
        
        let attributes = [NSFontAttributeName: self.font14, NSForegroundColorAttributeName: UIColor.white, NSParagraphStyleAttributeName: paragraphStyle]
        
        let content = "学习是一个循序渐进的过程\n我们愿为你搭建一座通往成功的彩虹阶梯\n请用心跟随我们的脚步，一步一步走向成功"
        let message = UILabel(frame: CGRect(x: 0, y: viewH * 0.36, width: viewW, height: 90))
        message.attributedText = NSAttributedString(string: content, attributes: attributes)
        message.numberOfLines = 3
        self.view.addSubview(message)
        
        var posXBt = 29
        if(self.view.frame.size.width == 375)
        {
            posXBt = 56
        }
        else if(self.view.frame.size.width == 414)
        {
            posXBt = 74
        }
        
        let btYouKe = UIButton(frame: CGRect(x: posXBt, y: Int(0.62*viewH), width: Int(viewW)-2*posXBt, height: 37))
        btYouKe.layer.cornerRadius = 4
        btYouKe.layer.masksToBounds = true
        btYouKe.layer.borderWidth = 1
        btYouKe.layer.borderColor = UIColor.white.cgColor
        btYouKe.titleLabel?.font = self.font14
        btYouKe.setTitleColor(.white, for: .normal)
        btYouKe.setTitle("游客访问", for: .normal)
        btYouKe.addTarget(self, action: #selector(WelcomeViewController.gotoVisitor(_:)), for: .touchUpInside)
        self.view.addSubview(btYouKe)
        
        let btLogin = UIButton(frame: CGRect(x: posXBt, y: Int(0.70*viewH), width: Int(viewW)-2*posXBt, height: 37))
        btLogin.layer.cornerRadius = 4
        btLogin.layer.masksToBounds = true
        btLogin.layer.borderWidth = 1
        btLogin.layer.borderColor = UIColor.white.cgColor
        btLogin.titleLabel?.font = self.font14
        btLogin.setTitleColor(.white, for: .normal)
        btLogin.setTitle("账号登陆", for: .normal)
        btLogin.addTarget(self, action: #selector(WelcomeViewController.gotoLogin(_:)), for: .touchUpInside)
        self.view.addSubview(btLogin)
        
        var posY = Int(0.78*viewH)
        if(self.view.frame.size.width == 414)
        {
            posY = Int(0.78*viewH)
        }
        let bt2View = ShadowView(frame: CGRect(x: posXBt, y: posY, width: Int(viewW)-2*posXBt, height: 37))
        bt2View.cornerRadius = 4.0
        bt2View.shadowRadius = 2.0
        bt2View.shadowOffset = CGSize(width: 0, height: 1)
        bt2View.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 126.0/255)
        bt2View.backgroundColor = .white
        self.view.addSubview(bt2View)
        
        let btReg = UIButton(frame: CGRect(x: 0, y: 0, width: Int(viewW)-2*posXBt, height: 37))
        btReg.titleLabel?.font = self.font14
        btReg.setTitleColor(self.fontColorRed, for: .normal)
        btReg.setTitle("账号注册", for: .normal)
        btReg.addTarget(self, action: #selector(WelcomeViewController.gotoRegister(_:)), for: .touchUpInside)
        bt2View.addSubview(btReg)
    }
    
    func gotoLogin(_ sender:UIButton)
    {
        self.performSegue(withIdentifier: "LoginController", sender: nil)
    }
    
    func gotoVisitor(_ sender:UIButton)
    {
        let vc = ControllerUtil.getTabController()
        UIApplication.shared.delegate?.window??.rootViewController = vc
        DataUtil.setVisitorLogin(value: true)
    }
    
    func gotoRegister(_ sender:UIButton)
    {
        self.performSegue(withIdentifier: "RegStep1Controller", sender: nil)
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
