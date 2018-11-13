//
//  HJLabel.swift
//  swift-UIlabel实例
//
//  Created by 研发ios工程师 on 2018/11/7.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//


import UIKit

class HJLabel: UILabel {

    static func creatLable(cg: CGRect, font: CGFloat, textAlignment:NSTextAlignment, textColor: UIColor, text:String) ->UILabel{
        let label = UILabel.init()
        label.frame = cg
        label.font = UIFont.systemFont(ofSize: font)
        label.isUserInteractionEnabled = true
        label.textAlignment = textAlignment
        label.textColor = textColor
        label.text = text
        return label
    } 

}
