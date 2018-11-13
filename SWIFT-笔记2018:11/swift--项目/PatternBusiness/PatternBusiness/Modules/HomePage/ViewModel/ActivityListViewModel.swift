//
//  ActivityListViewModel.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/5.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON

public class ActivityListViewModel: NSObject {

    var activityListArray = [ActivityListModel]()
    
    func loadActivityListData(typeRefresh:TypeRefresh,completeBlock: @escaping () -> ()) {
        
        if typeRefresh == .downRefresh {
            page = 0
        }
        if typeRefresh == .upRefresh {
            page += 1
        }
        let url = URL_main + ACTIVITY_LIST_INTERFACE + "pagesize=\(pageSize)" + "&" + "page=\(page)"
        print(url)
        QMNetworkTools.requestData(MethodType.get, URLString: url) { (dic) in
            //下拉刷新
            if typeRefresh == .downRefresh {
                if self.activityListArray.count > 0 {
                    self.activityListArray.removeAll()
                }
            }
            if dic["code"] as! Int == 200 {
                let result = dic["result"] as! NSDictionary
                if let data = result["list"] as? [Any] {
                    for listDic in JSON(data).array! {
                        let activityListModel = ActivityListModel(jsonData: listDic)
                        self.activityListArray.append(activityListModel)
                    }
                }
                if self.activityListArray.count > 0 {
                    completeBlock()
                }
            } else {
                print(dic["message"] as Any)
            }
            
        }
    }
    
}
