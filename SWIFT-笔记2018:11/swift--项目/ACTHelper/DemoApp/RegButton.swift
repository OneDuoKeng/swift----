//
//  RegButton.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/24.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class RegButton: ShadowView {
    
    var bt : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.cornerRadius = 4.0
        self.shadowRadius = 2.0
        self.shadowOffset = CGSize(width: 0, height: 1)
        self.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 126.0/255)
        
        let btFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        bt = UIButton(frame: btFrame)
        bt.titleLabel?.font = UIFont(name: "PingFang SC", size: 14)!
        bt.setTitleColor(.white, for: .normal)
        bt.setTitleColor(UIColor(red: 230.0/255, green: 230.0/255, blue: 230.0/255, alpha: 1.0), for: .disabled)
        bt.setTitle("", for: .normal)
        bt.backgroundColor = .clear
        self.addSubview(bt)
        
        self.deActive()
    }
    
    func active()
    {
        self.bt.isEnabled = true
        self.backgroundColor = UIColor(red: 255.0/255, green: 89.0/255, blue: 95.0/255, alpha: 1.0)
        self.bt.titleLabel?.textColor = UIColor.white
    }
    
    func deActive()
    {
        self.bt.isEnabled = false
        self.backgroundColor = UIColor.white
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
