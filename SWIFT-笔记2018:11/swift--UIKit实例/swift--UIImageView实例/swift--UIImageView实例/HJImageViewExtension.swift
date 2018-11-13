//
//  HJImageViewExtension.swift
//  swift--UIImageView实例
//
//  Created by 研发ios工程师 on 2018/11/8.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    func downloadedFrom(imageurl : String){
        //创建URL对象
        let url = URL(string: imageurl)!
        //创建请求对象
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if error != nil{
                print(error.debugDescription)
            }else{
                //将图片数据赋予UIImage
                let img = UIImage(data:data!)
                
                // 这里需要改UI，需要回到主线程
                DispatchQueue.main.async {
                    self.image = img
                }
                
            }
        }) as URLSessionTask
        
        //使用resume方法启动任务
        dataTask.resume()
    }
    
    
}
