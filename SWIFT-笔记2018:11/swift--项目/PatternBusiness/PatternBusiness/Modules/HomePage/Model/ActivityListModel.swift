//
//  ActivityListModel.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/5.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON

class ActivityListModel: NSObject {
    var address : String?
    
    var img : String?
    
    var official : String?
    
    var id : String?
    
    var etime : String?
    
    var title : String?
    
    var content : String?
    
    var link : String?
    
    var tag : String?
    
    var stime : String?
    
    init(jsonData: JSON) {
        
        address = jsonData["address"].stringValue
        
        img = jsonData["img"].stringValue
        
        official = jsonData["official"].stringValue
        
        id = jsonData["id"].stringValue
        
        etime = jsonData["etime"].stringValue
        
        title = jsonData["title"].stringValue
        
        content = jsonData["content"].stringValue
        
        link = jsonData["link"].stringValue
        
        tag = jsonData["tag"].stringValue
        
        stime = jsonData["stime"].stringValue
        
    }
}
