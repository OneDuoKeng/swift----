//
//  HomePageModel.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/5/30.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomePageModel: NSObject {
    
    var title : String?
    
    var ItemType : String?
    
    var Item : NSArray?
    
    init(jsonData: JSON) {
        
        title = jsonData["title"].stringValue
        
        ItemType = jsonData["ItemType"].stringValue
        
        Item = jsonData["Item"].array! as NSArray
    }

}
