//
//  CourseListViewModel.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/1.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON

class CourseListViewModel: NSObject {

    var courseListArray = [CourseListModel]()
        
    func loadCourseListData(typeRefresh:TypeRefresh,completeBlock:@escaping ()->()) {
        
        if typeRefresh == .downRefresh {
            page = 0
        }
        if typeRefresh == .upRefresh {
            page += 1
        }
        let url : String = URL_main + GOODS_LIST_INTERFACE + "pageSize=\(pageSize)" + "&" + "page=\(page)"
        print(url)
        QMNetworkTools.requestData(MethodType.get, URLString: url) { (dic) in
            if typeRefresh == .downRefresh {
                if self.courseListArray.count > 0 {
                    self.courseListArray.removeAll()
                }
            }
            let code : Int = dic["code"] as! Int
            if code == 200 {
                let result : NSDictionary = dic["result"] as! NSDictionary
                if let data = result["list"] as? [Any] {
                    for dic in JSON(data).array! {
                        let courseListDic = CourseListModel(jsonData: dic )
                        self.courseListArray.append(courseListDic)
                    }
                }
                if self.courseListArray.count > 0 {
                     completeBlock()
                }
            } else {
                print(dic["message"] as! String)
            }
        }
    }
}
