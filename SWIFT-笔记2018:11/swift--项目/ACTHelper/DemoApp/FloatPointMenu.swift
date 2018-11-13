//
//  FloatPointMenu.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/19.
//  Copyright © 2017年 www.coolketang.com. All rights reserved.
//

import UIKit

class FloatPointMenu: UIView {

    var isExpand : Bool = false
    var pointMenu : ShadowView!
    var pointShow : ShadowView!
    var pointClose : ShadowView!
    var whiteMask : UIView!
    var lblJump : UILabel!
    var lblShowArticle : UILabel!
    weak var controller : JieXiDetailViewController!
    var posX = 0
    var posY = 0
    let size = 50
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func buildUI()
    {
        let frame = controller.view.frame
        posX = Int(frame.size.width) - 20 - 50
        posY = Int(frame.size.height) - 80
        
        let shadowOpacity : CGFloat = 0.5
        pointMenu = ShadowView(frame: CGRect(x: posX, y: posY, width: size, height: size))
        pointMenu.backgroundColor = UIColor(red: 0.0, green: 125.0/255, blue: 125.0/255, alpha: 1.0)
        pointMenu.cornerRadius = CGFloat(size/2)
        pointMenu.shadowRadius = 3.0
        pointMenu.shadowOffset = CGSize(width: 0, height: 3)
        pointMenu.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: shadowOpacity)
        controller.view.addSubview(pointMenu)
        
        let icon = UIImage(named: "iconFloatPoint")
        let iconView = UIImageView(image: icon)
        iconView.frame = CGRect(x: 13.5, y: 13.5, width: 23, height: 23)
        pointMenu.addSubview(iconView)
        
        let guesture1 = UITapGestureRecognizer(target: self, action: #selector(FloatPointMenu.tapPointMenu(_:)))
        pointMenu.addGestureRecognizer(guesture1)
        
        pointShow = ShadowView(frame: pointMenu.frame)
        pointShow.backgroundColor = UIColor(red: 0.0, green: 125.0/255, blue: 125.0/255, alpha: 1.0)
        pointShow.cornerRadius = CGFloat(size/2)
        pointShow.shadowRadius = 3.0
        pointShow.shadowOffset = CGSize(width: 0, height: 3)
        pointShow.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: shadowOpacity)
        controller.view.insertSubview(pointShow, belowSubview: pointMenu)
        
        let icon2 = UIImage(named: "iconShow")
        let iconView2 = UIImageView(image: icon2)
        iconView2.frame = CGRect(x: 12.5, y: 12.5, width: 25, height: 25)
        pointShow.addSubview(iconView2)
        
        let guesture2 = UITapGestureRecognizer(target: self, action: #selector(FloatPointMenu.tapPointShow(_:)))
        pointShow.addGestureRecognizer(guesture2)
        
        pointClose = ShadowView(frame: pointMenu.frame)
        pointClose.backgroundColor = UIColor(red: 0.0, green: 125.0/255, blue: 125.0/255, alpha: 1.0)
        pointClose.cornerRadius = CGFloat(size/2)
        pointClose.shadowRadius = 3.0
        pointClose.shadowOffset = CGSize(width: 0, height: 3)
        pointClose.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: shadowOpacity)
        controller.view.insertSubview(pointClose, belowSubview: pointShow)
        
        let icon3 = UIImage(named: "iconClose")
        let iconView3 = UIImageView(image: icon3)
        iconView3.frame = CGRect(x: 15, y: 15, width: 20, height: 20)
        pointClose.addSubview(iconView3)
        
        let guesture3 = UITapGestureRecognizer(target: self, action: #selector(FloatPointMenu.tappointClose(_:)))
        pointClose.addGestureRecognizer(guesture3)
        
        lblJump = UILabel(frame: CGRect(x: -70, y: 20, width: 70, height: 20))
        lblJump.text = "题目跳转"
        lblJump.font = self.controller.font14
        lblJump.layer.opacity = 0.0
        lblJump.textColor = pointMenu.backgroundColor
        pointMenu.addSubview(lblJump)
        
        lblShowArticle = UILabel(frame: CGRect(x: -70, y: 20, width: 70, height: 20))
        lblShowArticle.text = "查看原题"
        lblShowArticle.font = self.controller.font14
        lblShowArticle.layer.opacity = 0.0
        lblShowArticle.textColor = pointMenu.backgroundColor
        pointShow.addSubview(lblShowArticle)
        
        whiteMask = UIView(frame: frame)
        whiteMask.backgroundColor = UIColor.white
        whiteMask.layer.opacity = 0.0
        whiteMask.isHidden = true
        let guesture4 = UITapGestureRecognizer(target: self, action: #selector(FloatPointMenu.tappointClose(_:)))
        whiteMask.addGestureRecognizer(guesture4)
        controller.view.insertSubview(whiteMask, belowSubview: pointClose)
    }
    
    func tapPointMenu(_ gusture:UITapGestureRecognizer)
    {
        if !isExpand
        {
            self.whiteMask.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                self.pointMenu.frame = CGRect(x: self.posX, y: self.posY - 130, width: self.size, height: self.size)
                self.pointShow.frame = CGRect(x: self.posX, y: self.posY - 65, width: self.size, height: self.size)
                self.whiteMask.layer.opacity = 0.6
                self.lblJump.layer.opacity = 1.0
                self.lblShowArticle.layer.opacity = 1.0
            }, completion: { finished in
                self.isExpand = !self.isExpand
            })
            
        }
        else
        {
            let vc = JumpQuestionViewController()
            vc.controller = self.controller
            vc.paperUUID = self.controller.paperId as String!
            vc.paperKeMu = self.controller.questionKemu
            vc.crtQuestionNum = self.controller.questionNumber
            let paperType = self.controller.questionType ?? ""
            let paperForm  = self.controller.paperForm ?? ""
            vc.paperTitle = "\(String(describing: paperType)) \(String(describing: paperForm))"
            self.controller.present(vc, animated: true, completion: nil)
        }
    }
    
    func tapPointShow(_ gusture:UITapGestureRecognizer)
    {
        let vc = ArticleViewController()
        vc.questionTitle = self.controller.questionTitle.text!
        vc.questionId = self.controller.questionId
        self.controller.present(vc, animated: true, completion: nil)
    }
    
    func tappointClose(_ gusture:UITapGestureRecognizer)
    {
        closeMenu()
    }
    
    func closeMenu()
    {
        if isExpand
        {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                self.pointMenu.frame = self.pointClose.frame
                self.pointShow.frame = self.pointClose.frame
                self.whiteMask.layer.opacity = 0.0
                self.lblJump.layer.opacity = 0.0
                self.lblShowArticle.layer.opacity = 0.0
            }, completion: { finished in
                self.isExpand = !self.isExpand
                self.whiteMask.isHidden = true
            })
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
