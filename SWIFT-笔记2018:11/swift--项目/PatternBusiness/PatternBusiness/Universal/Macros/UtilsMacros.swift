//
//  UtilsMacros.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/5/30.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit

class UtilsMacros: NSObject {

}
//MARK: ===================================变量宏定义=========================================

// MARK: 系统相关
/// Info
public let kAppBundleInfoVersion = Bundle.main.infoDictionary ?? Dictionary()
/// plist:  AppStore 使用VersionCode 1.0.1
public let kAppBundleVersion = (kAppBundleInfoVersion["CFBundleShortVersionString" as String] as? String ) ?? ""
/// plist: 例如 1
public let kAppBundleBuild = (kAppBundleInfoVersion["CFBundleVersion"] as? String ) ?? ""
public let kAppDisplayName = (kAppBundleInfoVersion["CFBundleDisplayName"] as? String ) ?? ""

// MARK: 系统相关
public let kiOSBase = 8.0
public let kOSGreaterOrEqualToiOS8 = ( (Double(UIDevice.current.systemVersion) ?? kiOSBase) > 8.0 ) ? true : false;
public let kOSGreaterOrEqualToiOS9 = ((Double(UIDevice.current.systemVersion) ?? kiOSBase) >= 9.0 ) ? true : false;
public let kOSGreaterOrEqualToiOS10 = ((Double(UIDevice.current.systemVersion) ?? kiOSBase) >= 10.0 ) ? true : false;
public let kOSGreaterOrEqualToiOS11 = ((Double(UIDevice.current.systemVersion) ?? kiOSBase) >= 11.0 ) ? true : false;

//设备宽高、机型
public let kScreenHeight = UIScreen.main.bounds.size.height
public let kScreenWidth = UIScreen.main.bounds.size.width
public let kStatusBarheight = UIApplication.shared.statusBarFrame.size.height
public let kNavBarHeight_StatusHeight: ((UIViewController)-> CGFloat) = {(vc : UIViewController ) -> CGFloat in
    weak var weakVC = vc;
    var navHeight = weakVC?.navigationController?.navigationBar.bounds.size.height ?? 0.0
    return (navHeight + kStatusBarheight)
}
public let proportionHeight = kScreenHeight/667.0
public let proportionWidth = kScreenWidth/375.0

// MARK: ============================================================================
// MARK: Dictory Array Strig Object 闭包方式
///过滤null对象
public let kFilterNullOfObj:((Any)->Any?) = {(obj: Any) -> Any? in
    if obj is NSNull {
        return nil
    }
    return obj
}

///过滤null的字符串，当nil时返回一个初始化的空字符串
public let kFilterNullOfString:((Any)->String) = {(obj: Any) -> String in
    if obj is String {
        return obj as! String
    }
    return ""
}

/// 过滤null的数组，当nil时返回一个初始化的空数组
public let kFilterNullOfArray:((Any)->Array<Any>) = {(obj: Any) -> Array<Any> in
    if obj is Array<Any> {
        return obj as! Array<Any>
    }
    return Array()
}


/// 过滤null的字典，当为nil时返回一个初始化的字典
public let kFilterNullOfDictionary:((Any) -> Dictionary<AnyHashable, Any>) = {( obj: Any) -> Dictionary<AnyHashable, Any> in
    if obj is Dictionary<AnyHashable, Any> {
        return obj as! Dictionary<AnyHashable, Any>
    }
    return Dictionary()
}


// MARK: ============================================================================
// MARK: 设置Nib、Stryboard、UIImage

/// 根据imageName创建一个UIImage
public let imageNamed:((String) -> UIImage? ) = { (imageName : String) -> UIImage? in
    return UIImage.init(named: imageName)
}


/// 根据Main.storyboard建立ViewController
public let VC_From_Main_SB:((String)-> UIViewController? ) = {(SBID : String) -> UIViewController? in
    return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier:SBID)
}


// MARK: ============================================================================
// MARK: 设置颜色
/// 设置颜色值
public let HexRGB:((Int) -> UIColor) = { (rgbValue : Int) -> UIColor in
    return HexRGBAlpha(rgbValue,1.0)
}

/// 通过 十六进制与alpha来设置颜色值  （ 样式： 0xff00ff ）
public let HexRGBAlpha:((Int,Float) -> UIColor) = { (rgbValue : Int, alpha : Float) -> UIColor in
    return UIColor(red: CGFloat(CGFloat((rgbValue & 0xFF0000) >> 16)/255), green: CGFloat(CGFloat((rgbValue & 0xFF00) >> 8)/255), blue: CGFloat(CGFloat(rgbValue & 0xFF)/255), alpha: CGFloat(alpha))
}


/// 通过 red 、 green 、blue 、alpha 颜色数值
public let RGBAlpa:((Float,Float,Float,Float) -> UIColor ) = { (r: Float, g: Float , b: Float , a: Float ) -> UIColor in
    return UIColor.init(red: CGFloat(CGFloat(r)/255.0), green: CGFloat(CGFloat(g)/255.0), blue: CGFloat(CGFloat(b)/255.0), alpha: CGFloat(a))
}
/// 字体
public let FontNameGeorgia : String = "Georgia"
public let FontNameZapfino : String = "Zapfino"


