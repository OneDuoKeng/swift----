//
//  ExtensionUIImage.swift
//  DemoApp
//
//  Created by Jerry on 16/5/20.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

extension UIImage
{
    func blendColor(_ color: UIColor, blendMode: CGBlendMode) -> UIImage
    {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        UIRectFill(rect)
        draw(in: rect, blendMode: blendMode, alpha: 1.0)
        
        let blendedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return blendedImage!
    }
}
