//
//  HomePageTopItemModel.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/1.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomePageTopItemModel: NSObject {

    var name : String?
    
    init(jsonData: JSON) {
        
        name = jsonData["name"].stringValue
        
    }
    
}
