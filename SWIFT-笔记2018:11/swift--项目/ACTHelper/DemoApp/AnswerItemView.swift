//
//  AnswerItemView.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/20.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class AnswerItemView: UIView {

    weak var controller : JieXiViewController!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var lblSeqNum : UILabel!
    var lblDaAn : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let size = Int(self.frame.size.width)
        let frame = CGRect(x: 0, y: 0, width: size, height: size)
        lblSeqNum = UILabel(frame: frame)
        lblSeqNum.text = ""
        lblSeqNum.textAlignment = .center
        lblSeqNum.backgroundColor = UIColor.white
        self.addSubview(lblSeqNum)
        
        let frame2 = CGRect(x: 0, y: size, width: size, height: size)
        lblDaAn = UILabel(frame: frame2)
        lblDaAn.text = ""
        lblDaAn.textAlignment = .center
        lblDaAn.backgroundColor = UIColor(red: 230.0/244, green: 230.0/244, blue: 230.0/244, alpha: 0.5)
        self.addSubview(lblDaAn)
    }
    
    func setParameters(seq:Int, daAn:String)
    {
        lblSeqNum.font = controller.font14
        lblSeqNum.textColor = controller.fontColorDarkGray
        lblDaAn.font = controller.font14
        lblDaAn.textColor = controller.fontColorDarkGray
        
        self.lblSeqNum.text = "\(seq)"
        self.lblDaAn.text = daAn
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
