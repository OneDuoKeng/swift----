//
//  UIColorExtension.swift
//  swift--UIColor扩展
//
//  Created by 研发ios工程师 on 2018/11/13.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
    
    // MARK: 扩充类方法
    class func getRandomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
    }
    
    // MARK: 扩充构造方法
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    // MARK: 解析传入的表示16进制颜色的字符串
    // hexString: 美工给的16进制颜色表示
    convenience init?(hexString: String) {
        
        // 1.判断字符串的长度是否大于等于6(格式正确才解析)
        guard hexString.characters.count >= 6 else {
            return nil
        }
        
        // 2.将字符串转成大写
        var hexTempString = hexString.uppercased()
        
        // 3.判断字符串是否以 ## 0X 0x 开头(因为美工给的颜色16进制表示不同,有的以0X开头,有的以##开头)
        if(hexTempString.hasPrefix("##") || hexTempString.hasPrefix("0X") || hexTempString.hasPrefix("0x")){
            // 从第2个字符的位置开始截取
            hexTempString = (hexTempString as NSString).substring(from: 2)
        }
        
        // 4.判断字符串是否以 # 开头
        if(hexTempString.hasPrefix("#")){
            // 从第1个字符的位置开始截取
            hexTempString = (hexTempString as NSString).substring(from: 1)
        }
        
        // 5.获取RGB分别对应的16进制(FF0022 -> r:FF g:00 b:22)
        var range = NSRange(location: 0, length: 2)
        let rHex = (hexTempString as NSString).substring(with: range)
        range.location = 2
        let gHex = (hexTempString as NSString).substring(with: range)
        range.location = 4
        let bHex = (hexTempString as NSString).substring(with: range)
        
        // 6.将16进制转成数值
        // UInt32 表示无符号的int32.就是不能是负数
        var r: UInt32 = 0
        var g: UInt32 = 0
        var b: UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }
}
