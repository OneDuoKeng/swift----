//
//  HomePageTopProphetModel.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/1.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomePageTopProphetModel: NSObject {

    var classid : String?
    
    var title : String?
    
    var name : String?
    
    var time : String?
    
    init(jsonData: JSON) {
        
        classid = jsonData["classid"].stringValue
        
        title = jsonData["title"].stringValue
        
        name = jsonData["name"].stringValue
        
        time = jsonData["time"].stringValue
        
    }
    
}
