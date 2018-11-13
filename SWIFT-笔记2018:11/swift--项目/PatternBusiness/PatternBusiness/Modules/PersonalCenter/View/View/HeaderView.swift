//
//  HeaderView.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/5/31.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 180)
        setupUI()
    }
    
    func setupUI()  {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        imageView.backgroundColor = UIColor.black
        imageView.layer.cornerRadius = 40
        imageView.center = self.center
        imageView.frame.origin.y = imageView.frame.origin.y - 20
        self.addSubview(imageView)
        
        let nameLB = UILabel(frame: CGRect(x: imageView.frame.origin.x, y: imageView.frame.origin.y+90, width: 80, height: 30))
        nameLB.backgroundColor = UIColor.orange
        self.addSubview(nameLB)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
