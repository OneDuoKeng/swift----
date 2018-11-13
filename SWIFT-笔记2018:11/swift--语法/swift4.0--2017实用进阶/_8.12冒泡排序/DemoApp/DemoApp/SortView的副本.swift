//
//  SortView.swift
//  AllKindsOfSortForiOS
//
//  Created by Mr.LuDashi on 16/11/14.
//  Copyright © 2016 ZeluLi. All rights reserved.
//

import UIKit

class SortView: UIView
{
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.frame = frame
    }
    
    override func layoutSubviews()
    {
        let y: CGFloat = 300 - frame.height
        self.frame = frame
        self.frame.origin.y = y
        
        let weight = frame.height / 200
        let color = UIColor(hue: weight, saturation: 1, brightness: 1, alpha: 1)
        self.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
