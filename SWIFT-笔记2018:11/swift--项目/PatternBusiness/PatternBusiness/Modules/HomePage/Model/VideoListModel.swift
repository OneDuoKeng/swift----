//
//  VideoListModel.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/13.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON

class VideoListModel: NSObject {
    var summary : String?
    
    var content : String?
    
    var id : String?
    
    var title : String?
    
    var count : String?
    
    var link : String?
    
    var duration : String?
    
    var path : String?
    
    var pics : String?
    
    init(jsonData: JSON) {
        
        summary = jsonData["summary"].stringValue
        
        content = jsonData["content"].stringValue
        
        id = jsonData["id"].stringValue
        
        title = jsonData["title"].stringValue
        
        count = jsonData["count"].stringValue
        
        link = jsonData["link"].stringValue
        
        duration = jsonData["duration"].stringValue
        
        path = jsonData["path"].stringValue
        
        pics = jsonData["pics"].stringValue
        
    }

}
