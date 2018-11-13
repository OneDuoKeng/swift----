//
//  ProjectListViewModel.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/7.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProjectListViewModel: NSObject {

    var projectListArray = [ProjectListModel]()
    
    func loadProjectListData(typeRefresh:TypeRefresh,completeBlock: @escaping ()->()) {
        
        if typeRefresh == .downRefresh {
            page = 0
        }
        if typeRefresh == .upRefresh {
            page += 1
        }
        
        let url = URL_main + GET_SPECIALLIST + "pageSize=\(pageSize)&page=\(page)"
        print(url)
        QMNetworkTools.requestData(MethodType.get, URLString: url) { (dic) in
            if typeRefresh == .downRefresh {
                if self.projectListArray.count > 0 {
                    self.projectListArray.removeAll()
                }
            }
            if dic["code"] as! Int == 200 {
//                QMHelper.printModelWithJson(dict: ((dic["result"] as! NSDictionary)["list"] as! NSArray)[0] as! NSDictionary)
                let result = dic["result"] as! NSDictionary
                
                if let data = result["list"] as? [Any] {
                    for listData in JSON(data).array! {
                        let projectListModel = ProjectListModel(jsonData: listData)
                        self.projectListArray.append(projectListModel)
                    }
                }
                
                if self.projectListArray.count > 0 {
                    completeBlock()
                }
                
            } else {
                print(dic["message"] as Any)
            }
            
            
        }
        
        
    }
    
    
}
