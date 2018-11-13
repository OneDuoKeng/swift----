//
//  JumpQuestionViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/19.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class JumpQuestionViewController: BaseViewController {

    var paperKeMu : String!
    var paperTitle : String!
    var paperUUID : String!
    var crtQuestionNum : Int!
    var bodyContainer : UIScrollView!
    var controller : JieXiDetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.layer.sublayers?[0].removeFromSuperlayer()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        self.backBt.isHidden = true
        self.dismissBt.isHidden = false
        self.view.backgroundColor = .white

        let title = UILabel(frame: CGRect(x: 20, y: 62, width: self.view.frame.size.width - 40, height: 28))
        title.text = self.paperTitle
        title.textColor = self.fontColorDarkGray
        title.font = self.font20
        self.view.addSubview(title)
        
        let bodyHeight = self.view.frame.size.height - 100
        let bodyFrame = CGRect(x: 0, y: 190, width: self.view.frame.size.width, height: bodyHeight)
        bodyContainer = UIScrollView(frame:bodyFrame)
        let color = CGFloat(255.0/255)
        bodyContainer.backgroundColor = UIColor(red: color, green: color, blue: color, alpha: 1.0)
        bodyContainer.isScrollEnabled = true
        self.view.addSubview(bodyContainer)
        
        let view = PassageListModelShow(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        view.controller = self
        
        let url = "\(self.baseUrl)iOS/jumpPaper.json"
        view.loadURL(url: url, parentView: self.bodyContainer)
    }
    
    func hidePointMenu()
    {
        controller.pointMenu.closeMenu()
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
