//
//  HJButton.swift
//  swift--UIButton实例
//
//  Created by 研发ios工程师 on 2018/11/7.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//  继承

import UIKit

class HJButton: UIButton {
    //在l扩展中写了 set方法 所以在这里 要加 override 表示继承父类  如果UIButtonExtension 没有写set方法 这里就不需要加override
    
    //    MARK: 快速创建图片加文字的btn 并设置位置
    @objc  override func set(image anImage: UIImage?, title: String,
                   titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    //private 私有的方法 外界不可调用
    private func positionLabelRespectToImage(title: String, position: UIView.ContentMode,
                                             spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
    //MARK: 快速创建原生Button
    static func creatButton(cg: CGRect, target: AnyObject, selector: Selector, titleColor: UIColor, backGroundImage: UIImage, title: String) ->UIButton{
        let bt = UIButton.init()
        bt.frame = cg
        bt.addTarget(target, action: selector, for: UIControl.Event.touchUpInside)
        bt.tintColor = titleColor
        bt.setBackgroundImage(backGroundImage, for: UIControl.State.normal)
        bt.setTitle(title, for: UIControl.State.normal)
        return bt
    }
}
