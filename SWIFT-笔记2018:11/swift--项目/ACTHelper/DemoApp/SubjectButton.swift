//
//  SubjectButton.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/13.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class SubjectButton: ShadowView {

    var label : UILabel!
    var isActive : Bool = false
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 157.0/255, green: 87.0/255, blue: 218.0/255, alpha: 1.0)
        self.cornerRadius = 4.0
        self.shadowRadius = 2.0
        self.shadowOffset = CGSize(width: 0, height: 1)
        self.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 126.0/255)
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        label.textColor = UIColor.white
        label.font = UIFont(name: "PingFang SC", size: 14)
        label.textAlignment = .center
        self.addSubview(label)
    }
    
    func setTitle(title:String)
    {
        label.text = title
    }
    
    func active()
    {
        isActive = true
        self.shadowRadius = 6.0
        self.shadowOffset = CGSize(width: 0, height: 5)
        self.backgroundColor = UIColor(red: 119.0/255, green: 20.0/255, blue: 206.0/255, alpha: 1.0)
    }
    
    func deActive()
    {
        isActive = false
        self.shadowRadius = 2.0
        self.shadowOffset = CGSize(width: 0, height: 1)
        self.backgroundColor = UIColor(red: 119.0/255, green: 20.0/255, blue: 206.0/255, alpha: 0.7)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
