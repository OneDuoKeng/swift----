//
//  BaseViewModel.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/7.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit

public enum TypeRefresh {
    case upRefresh
    case downRefresh
    case noRefresh
}

public var typeRefresh : TypeRefresh = TypeRefresh.downRefresh

public var page : Int = 0

public var pageSize : Int = 20

class BaseViewModel: NSObject {

}
