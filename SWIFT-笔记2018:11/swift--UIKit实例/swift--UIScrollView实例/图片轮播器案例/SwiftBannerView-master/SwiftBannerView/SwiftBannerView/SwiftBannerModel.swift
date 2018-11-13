//
//  SwiftBannerModel.swift
//  SwiftBannerView
//
//  Created by LuKane on 2018/5/21.
//  Copyright © 2018年 LuKane. All rights reserved.
//
/**
 * 使用 SwiftBannerView的过程中,有任何bug或问题,都可以在github上提出 issue
 * 或者 联系QQ: 1169604556
 * Github: https://github.com/LuKane
 */

import UIKit

// pageControl 的显示 方式
public enum SwiftBannerPageControlStyle : Int {
    case right
    case left
    case middle
}

// 文字的 显示方式
public enum SwiftBannerViewTextShowStyle : Int {
    case right
    case left
    case middle
}

public enum SwiftBannerViewTextChangeStyle : Int {
    case follow // 随cell 一起滚动
    case stay   // 待着不动
}

class SwiftBannerModel: NSObject {

/****************************** == Banner 通用 == ********************************/

    // 是否需要 无限循环
    var isNeedCycle : Bool? // 默认 false
    // 是否需要 定时器跑
    var isNeedTimerRun : Bool? // 默认 false
    // 网络图片的 占位图
    var placeHolder : UIImage?
    // 定时器的 时间
    var timeInterval : Double? // 默认为 1.5s
    // 是否需要 pageControl
    var isNeedPageControl : Bool? // 默认为 NO
    // 左边 和 右边 间距 , 如果设置数值,则左右有间距
    var leftMargin : CGFloat? // 默认 : 0
    // 周边 圆角  , 如果设置数值, 则有圆角大小
    var bannerCornerRadius : CGFloat? // 默认为 0
    // 模仿 天猫 首页banner 动态修改背景色
    var bgChangeColorArr : NSArray?
    
/****************************** == pageControl == ********************************/
    
    // 自定义 pageControl 的图片数组 , 如果设置,则是自定义 pageControl
    var pageControlImgArr : NSArray?
    // pageControl 的 当前下标
    var currentPage : Int?
    // pageControl 的总数
    var numberOfPages : Int?
    // 系统pageControl 的 当前选中颜色, 默认绿色
    var currentPageIndicatorTintColor : UIColor?
    // 系统pageControl 的 当前未选中颜色, 默认白色
    var pageIndicatorTintColor : UIColor?
    // pageControl 的显示样式, 默认居右
    var pageControlStyle : SwiftBannerPageControlStyle?
    
/****************************** == 文字 == ********************************/
    
    // 文字的默认高度 : 默认 30
    var textHeight : CGFloat = 30
    // 文字的滚动方式 : 默认 一起滚动 .follow
    var textChangeStyle : SwiftBannerViewTextChangeStyle?
    // 文字的显示方式 : 默认 局左
    var textShowStyle : SwiftBannerViewTextShowStyle?
    // 文字的字体颜色 : 默认 白色
    var textColor : UIColor?
    // 文字的字体大小 : 默认 [UIFont fontWithName:@"Heiti SC" size:15]
    var textFont : UIFont?
    // 文字的背景颜色 : 默认 UIColor.black
    var textBackGroundColor : UIColor?
    // 文字背景的透明度 : 默认 0.7
    var textBackGroundAlpha : CGFloat?
    // 是否需要 text : 不做 API
    var isNeedText : Bool?
    // 是否需要文字, 如果需要 则设置 textArr (如果textArr 和 图片个数 不相等, 则隐藏text)
    var textArr : NSArray?
    
}
