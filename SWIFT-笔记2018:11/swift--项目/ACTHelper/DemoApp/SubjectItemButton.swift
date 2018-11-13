//
//  SubjectButton.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/13.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class SubjectItemButton: ShadowView {

    var button : UIButton!
    var itemTitle : String = ""
    var itemUUID : String = ""
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.cornerRadius = 4.0
        self.shadowRadius = 2.0
        self.shadowOffset = CGSize(width: 0, height: 1)
        self.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 126.0/255)
        
        button = UIButton(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        button.setTitleColor(UIColor(red: 74.0/255, green: 74.0/255, blue: 74.0/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont(name: "PingFang SC", size: 14)
        self.addSubview(button)
    }
    
    func active()
    {
        self.button.setTitleColor(.white, for: .normal)
        self.shadowRadius = 6.0
        self.shadowOffset = CGSize(width: 0, height: 5)
        self.backgroundColor = UIColor(red: 119.0/255, green: 20.0/255, blue: 206.0/255, alpha: 1.0)
    }
    
    func setTitle(title:String)
    {
        button.setTitle(title, for: .normal)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
