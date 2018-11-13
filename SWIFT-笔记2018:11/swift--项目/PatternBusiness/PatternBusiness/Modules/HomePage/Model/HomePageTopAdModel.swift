//
//  HomePageTopAdModel.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/1.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomePageTopAdModel: NSObject {

    var pi_img : String?
    
    var pi_type : String?
    
    var pi_name : String?
    
    var pi_val : String?
    
    init(jsonData: JSON) {
        
        pi_img = jsonData["pi_img"].stringValue
        
        pi_type = jsonData["pi_type"].stringValue
        
        pi_name = jsonData["pi_name"].stringValue
        
        pi_val = jsonData["pi_val"].stringValue
        
    }

}
