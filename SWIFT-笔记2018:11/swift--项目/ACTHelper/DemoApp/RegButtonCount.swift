//
//  RegButtonCount.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/24.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class RegButtonCount: RegButton {
    
    var baseNum : UInt = 60
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func countTime()
    {
        self.deActive()
        baseNum = 60
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RegButtonCount.timerAction(_:)), userInfo: nil, repeats: true)
    }
    
    func timerAction(_ timer:Timer)
    {
        baseNum -= 1
        self.bt.setTitle("重新获取 \(baseNum)S", for: .normal)
        
        if(baseNum <= 0)
        {
            baseNum = 60
            self.active()
            self.bt.setTitle("重新获取", for: .normal)
            timer.invalidate()
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
