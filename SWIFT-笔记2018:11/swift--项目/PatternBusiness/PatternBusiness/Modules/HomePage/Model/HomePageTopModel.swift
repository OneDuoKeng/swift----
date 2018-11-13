//
//  HomePageTopModel.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/1.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomePageTopModel: NSObject {

    var Item : HomePageTopItemModel!
    
//    var ad : [HomePageTopAdModel]?
    var ad : HomePageTopAdModel!
    
    var prophet : HomePageTopProphetModel!
    
    init(jsonData: JSON) {
        
        Item = HomePageTopItemModel(jsonData: jsonData["Item"])
//        var array = [HomePageTopAdModel]()
//        if let arr = jsonData["ad"].array {
//            for dic in arr {
//                array.append(HomePageTopAdModel(jsonData: dic))
//            }
//        }
//        ad = array
        ad = HomePageTopAdModel(jsonData: jsonData["ad"])
        
        prophet = HomePageTopProphetModel(jsonData: jsonData["prophet"])
        
    }
}
