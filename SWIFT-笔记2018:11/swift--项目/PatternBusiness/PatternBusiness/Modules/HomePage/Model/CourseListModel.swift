//
//  CourseListModel.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/1.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON

class CourseListModel: NSObject {

    var goods_name : String?
    
    var goodsid : String?
    
    var goods_summary : String?
    
    var goods_start : String?
    
    var goods_end : String?
    
    var goods_img : String?
    
    init(jsonData: JSON) {
        
        goods_name = jsonData["goods_name"].stringValue
        
        goodsid = jsonData["goodsid"].stringValue
        
        goods_summary = jsonData["goods_summary"].stringValue
        
        goods_start = jsonData["goods_start"].stringValue
        
        goods_end = jsonData["goods_end"].stringValue
        
        goods_img = jsonData["goods_img"].stringValue
        
    }

}
