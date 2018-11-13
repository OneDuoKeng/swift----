//
//  HomePageViewModel.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/5/29.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomePageViewModel:NSObject {
    /// 数据源数组
    var groupingArray = [HomePageModel]()
    //头部数据
    var homePageHeaderDic : HomePageTopModel!
    
    var headerDic : NSDictionary!
    
    /// 首页请求数据
    ///
    /// - Parameter completeBlock: 返回请求结果
    func loadHomePageData(completeBlock: @escaping() -> ()) {
        let url:String = URL_main+GET_HOME_INTERFACE
        print(url)
        QMNetworkTools.requestData(MethodType.get, URLString: url) {(dict) in
            
            let code : Int = dict["code"] as! Int
            if code == 200 {
                print("请求成功")
                let result : NSDictionary = dict["result"] as! NSDictionary
                //头数据
                self.headerDic = result["top"] as! NSDictionary
                //列表数据
                let middleArray : NSArray = result["middle"] as! NSArray
//                QMHelper.printModelWithJson(dict: middleArray[0] as! NSDictionary)
                for itemDic in JSON(middleArray).array! {
                    let homePageDic = HomePageModel(jsonData: itemDic)
                    let itemArray : NSArray = homePageDic.Item!
                    //过滤
                    if itemArray.count > 0 {
                        self.groupingArray.append(homePageDic)
//                        print("----\(itemDic)")
                    }
                }
                if self.groupingArray.count > 0 {
                     completeBlock()
                }
            } else {
//                print(dict["message"] as! String)
            }
        }
    }
    
}
