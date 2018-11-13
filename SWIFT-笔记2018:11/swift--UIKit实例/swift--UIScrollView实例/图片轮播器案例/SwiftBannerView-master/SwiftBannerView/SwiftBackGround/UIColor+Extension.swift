//
//  UIColor+Extension.swift
//  Swift-Test
//
//  Created by LuKane on 2018/2/11.
//  Copyright © 2018年 LuKane. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /* 通过 色值 设置颜色 */
    public class func colorWithHex(_ hex : String) -> UIColor {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hex:   String  = hex
        
        if hex.hasPrefix("#") {
            let index = hex.index(hex.startIndex, offsetBy: 1)
            hex = String(hex[index...])
        }
        
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default: break
                
            }
        }
        return self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    /* 通过 RGB 设置颜色 */
    public class func colorWithRGB(red : CGFloat , green : CGFloat , blue : CGFloat) -> UIColor{
        return UIColor.colorWithRGBA(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    /* 通过 RGBA 设置颜色 */
    public class func colorWithRGBA(red : CGFloat , green : CGFloat , blue : CGFloat , alpha : CGFloat) -> UIColor{
        let color : UIColor = UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
        return color
    }
    
    /* 获取 随机颜色 */
    public class func colorOfRandom() -> UIColor{
        let hue = arc4random() % 256 % 256
        let saturation = CGFloat(CGFloat(arc4random() % 128) / 256.0) + 0.5
        let brightness = CGFloat(CGFloat(arc4random() % 128) / 256.0) + 0.5
        
        return UIColor.init(hue: CGFloat(hue), saturation: CGFloat(saturation), brightness: CGFloat(brightness), alpha: 1)
    }
    
    public class func coloWithHexString(hexString : String) -> UIColor{
        let invalidCharacters : NSMutableCharacterSet = NSMutableCharacterSet.whitespacesAndNewlines as! NSMutableCharacterSet
        invalidCharacters.addCharacters(in: "#")
        
        let hex = hexString.trimmingCharacters(in: invalidCharacters as CharacterSet).replacingOccurrences(of: "0x", with: "")
        
        let count : NSInteger = hex.count % 2
        if hex.count < 6 || count != 0{
            return UIColor.gray
        }
        
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (hex as NSString).substring(with: range)
        range.location = 2
        let gString = (hex as NSString).substring(with: range)
        range.location = 4
        let bString = (hex as NSString).substring(with: range)
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        
        return UIColor(displayP3Red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
    }
    
}
