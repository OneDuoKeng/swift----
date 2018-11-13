//
//  MostRequestsViewModel.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/13.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON

class MostRequestsViewModel: NSObject {

    var videoListArray = [VideoListModel]()
    
    //专辑详情
    func loadAlbumDetailsData(albumDetailsID : String, completeBlock: @escaping (_ dicData:VideoListModel,_ videoListArray:[VideoListModel])->()){
       
        let url = URL_main + SPECIAL_NEW_ITEM_DETAIL_INTERACE + "id=\(albumDetailsID)"
   
        print(url)
       
        QMNetworkTools.requestData(MethodType.get, URLString: url) { (dic) in

//            QMHelper.printModelWithJson(dict: (dic["result"] as! NSDictionary)["detail"] as! NSDictionary)
            
            if dic["code"] as! Int == 200 {
                let result = dic["result"] as! NSDictionary
                if let data = result["list"] as? [Any] {
                    for listData in JSON(data).array! {
                        let videoListModel = VideoListModel(jsonData: listData)
                        self.videoListArray.append(videoListModel)
                    }
                    
                    let detail = VideoListModel(jsonData: JSON((dic["result"] as! NSDictionary)["detail"] ?? 0))
                    
                    if self.videoListArray.count > 0 {
                        completeBlock(detail, self.videoListArray)
                    }
                }
            } else {
                print(dic["message"] ?? 0)
            }
        }
       
    }
    
}
