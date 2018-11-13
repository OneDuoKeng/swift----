//
//  ProjectListModel.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/7.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProjectListModel: NSObject {
    var id : String?
    
    var title : String?
    
    var img : String?
    
    var summary : String?
    
    init(jsonData: JSON) {
        
        id = jsonData["id"].stringValue
        
        title = jsonData["title"].stringValue
        
        img = jsonData["img"].stringValue
        
        summary = jsonData["summary"].stringValue
        
    }

}
