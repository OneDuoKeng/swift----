//
//  UrlMacros.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/5/30.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit

class UrlMacros: NSObject {

}
//版本号
public let KVersionCode = 2.0

/// 测试+开发+生产(域名)
public let DevelopDomainName = "http://dev.geju.com/"
public let TestDomainName = "http://dev.geju.com/"
public let ProductDomainName = "http://api.geju.com/"

public let API = "api-v\(KVersionCode)/"

public let URL_main = "\(ProductDomainName)\(API)"

/// 首页接口
public let GET_HOME_INTERFACE = "get-home?"
//  首页活动
public let ACTIVITY_LIST_INTERFACE = "activity-list?"
//  首页课程列表
public let GOODS_LIST_INTERFACE = "goods-list?"
//  专题列表
public let GET_SPECIALLIST = "special-list?"
//  专辑详情
public let SPECIAL_NEW_ITEM_DETAIL_INTERACE = "special-new-item-detail?"

