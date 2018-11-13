//
//  BaseViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/3/28.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

enum TabType : Int {
    case Analysis = 1
    case Answer = 2
}

enum PaperType : Int{
    case ACT = 1
    case SAT = 2
}

class BaseViewController: UIViewController {
    
    let baseUrl = "http://www.coolketang.com/"
    var backBt : UIButton!
    var dismissBt : UIButton!
    let fontColorDarkGray : UIColor = UIColor(red: 74.0/255, green: 74.0/255, blue: 74.0/255, alpha: 1.0)
    let fontColorLightGray : UIColor = UIColor(red: 229.0/255, green: 229.0/255, blue: 229.0/255, alpha: 1.0)
    let fontColorRed : UIColor = UIColor(red: 255.0/255, green: 89.0/255, blue: 95.0/255, alpha: 1.0)
    let fontColorGreen : UIColor = UIColor(red: 0.0/255, green: 126.0/255, blue: 125.0/255, alpha: 1.0)
    let fontColorBlue : UIColor = UIColor(red: 74.0/255, green: 144.0/255, blue: 226.0/255, alpha: 1.0)
    let fontColorSplit : UIColor = UIColor(red: 230.0/255, green: 230.0/255, blue: 230.0/255, alpha: 0.5)
    let fontName : String = "PingFang SC"
    let font14 : UIFont = UIFont(name: "PingFang SC", size: 14)!
    let font17 : UIFont = UIFont(name: "PingFang SC", size: 17)!
    let font20 : UIFont = UIFont(name: "PingFang SC", size: 20)!
    let font24 : UIFont = UIFont(name: "PingFang SC", size: 24)!
    var width40 : Int = 0
    var widthFull : Int = 0
    var heightFull : Int = 0
    var startPoint : CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        self.navigationItem.hidesBackButton = true
        
        // Do any additional setup after loading the view.
        self.width40 = Int(self.view.frame.size.width) - 40
        self.heightFull = Int(self.view.frame.size.height)
        self.widthFull = Int(self.view.frame.size.width)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.bounds = CGRect(x: 0, y: 0, width: self.widthFull+1, height: self.heightFull+1)
        gradientLayer.position = CGPoint(x: self.widthFull/2, y: self.heightFull/2)
        gradientLayer.colors = [UIColor(red: 48.0/255, green: 35.0/255, blue: 174.0/255, alpha: 1.0).cgColor, UIColor(red: 126.0/255, green: 67.0/255, blue: 170.0/255, alpha: 1.0).cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 1, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        backBt = UIButton(frame: CGRect(x: 11, y: 26, width: 33, height: 33))
        backBt.setImage(UIImage(named:"LeftArrow"), for: .normal)
        backBt.addTarget(self, action: #selector(BaseViewController.backBtTapped(_:)), for: .touchUpInside)
        self.view.addSubview(backBt)
        
        dismissBt = UIButton(frame: CGRect(x: 13, y: 20, width: 40, height: 40))
        dismissBt.setImage(UIImage(named:"iconCloseBlack"), for: .normal)
        dismissBt.addTarget(self, action: #selector(BaseViewController.dismissBtTapped(_:)), for: .touchUpInside)
        dismissBt.isHidden = true
        self.view.addSubview(dismissBt)
    }
    //MARK: -
    //MARK: back
    func backBtTapped(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: cancel
    func dismissBtTapped(_ sender:UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: KeyboardHeight
    func getKeyboardHeight() -> Int
    {
        let lang = UITextInputMode.activeInputModes[0] 
        let primaryLanguage = lang.primaryLanguage
        if(primaryLanguage == "en-US")
        {
            return 253
        }
        else if(primaryLanguage == "zh-CN")
        {
            if(self.view.frame.size.width == 414)
            {
                return 256+40
            }
            else
            {
                return 256
            }
        }
        else if(primaryLanguage == "zh-Hans")
        {
            if(self.view.frame.size.width == 414)
            {
                return 216+40
            }
            else
            {
                return 216
            }
            
        }
        else if(primaryLanguage == "emoji")
        {
            return 216
        }
        
        return 253
    }
    
    //MARK: -
    //MARK: touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        startPoint = touch?.location(in: self.view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        let touchPoint = touch?.location(in: self.view)
        
        let disX = (touchPoint?.x)! - (startPoint?.x)!
        let disY = abs((touchPoint?.y)! - (startPoint?.y)!)
        
        if(disY < 10 && disX > 50)
        {
            if(self.navigationController != nil)
            {
                startPoint = CGPoint(x: 0, y: 0)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        startPoint = CGPoint(x: 0, y: 0)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        startPoint = CGPoint(x: 0, y: 0)
    }
    
    func hideTabBar()
    {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func showTabBar()
    {
        self.tabBarController?.tabBar.isHidden = false
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
