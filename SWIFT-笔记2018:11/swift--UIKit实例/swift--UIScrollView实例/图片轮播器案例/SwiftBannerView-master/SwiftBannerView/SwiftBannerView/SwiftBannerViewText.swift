//
//  SwiftBannerViewText.swift
//  SwiftBannerView
//
//  Created by LuKane on 2018/5/28.
//  Copyright © 2018年 LuKane. All rights reserved.
//
/**
 * 使用 SwiftBannerView的过程中,有任何bug或问题,都可以在github上提出 issue
 * 或者 联系QQ: 1169604556
 * Github: https://github.com/LuKane
 */
import UIKit

class SwiftBannerViewText: UIView {
    
    lazy var textLabel : UILabel = { ()-> UILabel in
        let label : UILabel = UILabel()
        return label
    }()
    
    var text : String? {
        didSet {
            self.textLabel.text = text
        }
    }
    
    var bannerM : SwiftBannerModel? {
        didSet {
            
            self.backgroundColor = bannerM?.textBackGroundColor
            self.alpha = (bannerM?.textBackGroundAlpha)!
            
            textLabel.textColor = bannerM?.textColor
            textLabel.font = bannerM?.textFont
            
            switch bannerM?.textShowStyle {
                case .left?:
                    textLabel.textAlignment = .left
                    break
                case .right?:
                    textLabel.textAlignment = .right
                    break
                case .middle?:
                    textLabel.textAlignment = .center
                    break
                default:
                    break
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch bannerM?.textShowStyle {
            
        case .left?:
            textLabel.frame = CGRect(x: 10, y: 0, width: self.width - 10, height: self.height)
            break
            
        case .right?:
            textLabel.frame = CGRect(x: 0, y: 0, width: self.width - 10, height: self.height)
            break
            
        case .middle?:
            textLabel.frame = self.bounds
            break
            
        default:
            break
        }
    }
}
