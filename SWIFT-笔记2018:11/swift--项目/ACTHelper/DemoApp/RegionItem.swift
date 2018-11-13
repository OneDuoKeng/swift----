//
//  RegionItem.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/13.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class RegionItem: ShadowView {
    
    var keMu : String!
    var tiKuType : String!
    var tiKuUuid : String!
    var colorBar : UIView!
    var titleLabel : UILabel!
    var numLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        colorBar = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: frame.size.height))
        colorBar.backgroundColor = UIColor(red: 245.0/255, green: 166.0/255, blue: 35.0/255, alpha: 1.0)
        self.addSubview(colorBar)
        
        let path = UIBezierPath(roundedRect: colorBar.bounds, byRoundingCorners: [UIRectCorner.topLeft,UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 4, height: 4))
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = colorBar.bounds
        shapeLayer.path = path.cgPath
        colorBar.layer.mask = shapeLayer
        
        titleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: 260, height: frame.size.height))
        titleLabel.text = "亚洲真题 70C"
        titleLabel.textColor = UIColor(red: 74.0/255, green: 74.0/255, blue: 74.0/255, alpha: 1.0)
        titleLabel.font = UIFont(name: "PingFang SC", size: 14)
        self.addSubview(titleLabel)
        
        let iconStar = UIImageView(image: UIImage(named: "iconStar"))
        iconStar.frame = CGRect(x: frame.size.width - 80, y: 12, width: 20, height: 20)
        self.addSubview(iconStar)
        
        numLabel = UILabel(frame: CGRect(x: frame.size.width - 50, y: 0, width: 60, height: frame.size.height))
        numLabel.text = "0"
        numLabel.font = UIFont(name: "PingFang SC", size: 14)
        numLabel.textColor = UIColor(red: 74.0/255, green: 74.0/255, blue: 74.0/255, alpha: 1.0)
        self.addSubview(numLabel)
        
        
        self.backgroundColor = UIColor.white
        self.cornerRadius = 4.0
        self.shadowRadius = 2.0
        self.shadowOffset = CGSize(width: 0, height: 1)
        self.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 126.0/255)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setParameters(color:UIColor, title:String, num:Int, tiKuType:String, tiKuId:String, keMu:String)
    {
        self.colorBar.backgroundColor = color
        self.titleLabel.text = title
        self.numLabel.text = "\(num)"
        self.tiKuType = tiKuType
        self.tiKuUuid = tiKuId
        self.keMu = keMu
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
