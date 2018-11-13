//
//  CustomCheckBox.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/14.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class CustomCheckBox: ShadowView {

    var titleLabel : UILabel!
    var checkIcon : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 126.0/255, green: 87.0/255, blue: 194.0/255, alpha: 0.9)
        self.cornerRadius = 4.0
        self.shadowRadius = 2.0
        self.shadowOffset = CGSize(width: 1, height: 1)
        self.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 126.0/255)
        
        titleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: self.frame.size.width-20, height: self.frame.size.height))
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "PingFang SC", size: 14)
        self.addSubview(titleLabel)
        
        let arrow = UIImage(named: "iconArrow")
        checkIcon = UIImageView(frame: CGRect(x: self.frame.size.width - 35, y: 15, width: 15, height: 15))
        checkIcon.image = arrow
        checkIcon.isHidden = true
        self.addSubview(checkIcon)
    }
    
    func setTitle(title:String)
    {
        self.titleLabel.text = title
    }
    
    func active()
    {
        self.backgroundColor = UIColor.white
        self.titleLabel.textColor = UIColor(red: 126.0/255, green: 87.0/255, blue: 194.0/255, alpha: 0.9)
        checkIcon.isHidden = false
    }
    
    func deActive()
    {
        self.backgroundColor = UIColor(red: 126.0/255, green: 87.0/255, blue: 194.0/255, alpha: 0.9)
        checkIcon.isHidden = true
        self.titleLabel.textColor = UIColor.white
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
