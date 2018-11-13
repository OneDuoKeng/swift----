//
//  DataUtil.swift
//  DemoApp
//
//  Created by Jerry on 2017/5/4.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Toaster
import PKHUD
import Qiniu

class DataUtil
{
    class func hasLogined() -> Bool
    {
        return UserDefaults.standard.bool(forKey: "hasLogin")
    }
    class func setLogined()
    {
        UserDefaults.standard.set(true, forKey: "hasLogin")
        UserDefaults.standard.synchronize()
    }
    class func setLoginOut()
    {
        UserDefaults.standard.set(false, forKey: "hasLogin")
        UserDefaults.standard.synchronize()
    }
    
    class func hasShowIntro() -> Bool
    {
        return UserDefaults.standard.bool(forKey: "hasShowIntro")
    }
    class func setShowInfo()
    {
        UserDefaults.standard.set(true, forKey: "hasShowIntro")
        UserDefaults.standard.synchronize()
    }
    
    class func getTabBarHeight(vc:UIViewController) -> CGFloat
    {
        return (vc.tabBarController?.tabBar.frame.size.height)!
    }
    
    class func setCrtUser(userInfo : UserInfo)
    {
        let data = NSMutableData()
        let archive = NSKeyedArchiver(forWritingWith: data)
        archive.encode(userInfo, forKey: "crtUserInfo")
        archive.finishEncoding()
        
        let filePath = NSHomeDirectory() + "/Documents/crtUserInfo.data"
        data.write(toFile: filePath, atomically: true)
    }
    
    class func getCrtUser() -> UserInfo
    {
        let filePath = NSHomeDirectory() + "/Documents/crtUserInfo.data"
        let fileData = NSMutableData(contentsOfFile: filePath)
        let unarchiver = NSKeyedUnarchiver(forReadingWith: fileData! as Data)
        
        let savedUser = unarchiver.decodeObject(forKey: "crtUserInfo") as! UserInfo
        unarchiver.finishDecoding()
        
        return savedUser
    }
    
    class func setVisitorLogin(value:Bool)
    {
        UserDefaults.standard.set(value, forKey: "IsVisitorLogin")
        UserDefaults.standard.synchronize()
    }
    
    class func isVisitorLogin() -> Bool
    {
        return UserDefaults.standard.bool(forKey: "IsVisitorLogin")
    }
    
    class func saveAvarta(data:Data)
    {
        let targetPath:String = NSHomeDirectory() + "/Documents/avarta.png"
        try? data.write(to: URL(fileURLWithPath: targetPath))
    }
    
    class func getAvarta() -> UIImage?
    {
        let targetPath:String = NSHomeDirectory() + "/Documents/avarta.png"
        
        let image = UIImage(contentsOfFile: targetPath)
        return image
    }
    
    class func setAvartaForImageView(imageView : UIImageView)
    {
        let localImage = getAvarta()
        if(localImage == nil)
        {
            let user = getCrtUser()
            let imageUrl = user.head_img
            if(imageUrl != "")
            {
                let url = URL(string: imageUrl)
                let request = URLRequest(url: url!)
                
                NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main, completionHandler: {(response:URLResponse?, data:Data?,error:Error?)->Void in
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        let image = UIImage(data: data!)
                        imageView.image = image
                    })
                })
            }
            else
            {
                imageView.image = UIImage(named: "defaultAvarta")
            }
        }
        else
        {
            imageView.image = localImage
        }
    }
    
    class func uploadAvartaToQiNiu(baseUrl: String, avarta: UIImage)
    {
        let url = "\(baseUrl)iOS/uploadAvarta.json"
        
        HUD.show(.progress)
        ToastView.appearance().font = UIFont(name: "PingFang SC", size: 14)!
        
        Alamofire.request(url, method: .get).responseJSON
            { response in
                print(response)
                if let json = response.result.value as? [String: Any]
                {
                    print("JSON: \(json)")
                    let code = json["code"] as? Int ?? 0
                    let detail = json["detail"] as? [String: Any]
                    
                    ToastView.appearance().bottomOffsetPortrait = 150
                    if(code == 0)
                    {
                        let upload_name = detail?["upload_name"] as? String ?? ""
                        let upload_token = detail?["upload_token"] as? String ?? ""
                        print(upload_token)
                        
                        let upManager = QNUploadManager()
                        let data = UIImagePNGRepresentation(avarta)
                        
                        upManager?.put(data, key: upload_name, token: upload_token, complete:{ (info, key, resp) -> Void in
                            
                            print(info)
                            print("----------")
                            print(resp)
                            if (info?.statusCode == 200 && resp != nil)
                            {
                                let userInfo = DataUtil.getCrtUser()
                                let url = "\(baseUrl)iOS/headImage.json"
                                let parameters = ["head_img": "http://www.coolketang.com/\(upload_name)"]
                                
                                Alamofire.request(url, method: .get, parameters: parameters).responseJSON
                                    { response in
                                        
                                        HUD.hide(animated: true)
                                        if let json = response.result.value as? [String: Any]
                                        {
                                            print("JSON: \(json)")
                                            let code = json["code"] as? Int ?? 0
                                            
                                            if(code == 0)
                                            {
                                                ToastView.appearance().bottomOffsetPortrait = 80
                                                Toast(text: "Image was successfully uploaded!").show()
                                                
                                                let detail = json["detail"] as? [String: Any]
                                                userInfo.head_img = detail?["head_img"] as? String ?? ""
                                                DataUtil.setCrtUser(userInfo: userInfo)
                                                
                                                DataUtil.saveAvarta(data: data!)
                                            }
                                            else
                                            {
                                                let detail = json["detail"] as? String ?? ""
                                                ToastView.appearance().bottomOffsetPortrait = 80
                                                Toast(text: detail).show()
                                                
                                            }
                                        }
                                        else
                                        {
                                            ToastView.appearance().bottomOffsetPortrait = 80
                                            Toast(text: "Upload failed!").show()
                                        }
                                }
                            }
                            else
                            {
                                HUD.hide(animated: true)
                            }
                            
                        }, option: nil)
                    }
                    else
                    {
                        ToastView.appearance().bottomOffsetPortrait = 80
                        Toast(text: "Upload failed!").show()
                        
                        HUD.hide(animated: true)
                    }
                }
                else
                {
                    ToastView.appearance().bottomOffsetPortrait = 80
                    Toast(text: "Upload failed!").show()
                    
                    HUD.hide(animated: true)
                }
        }
    }
}

func getKemuBySection(section: String) -> String
{
    if(section == "english")
    {
        return "英语"
    }
    else if(section == "math")
    {
        return "数学"
    }
    else if(section == "reading")
    {
        return "阅读"
    }
    else if(section == "science")
    {
        return "科学"
    }
    else if(section == "language")
    {
        return "语言"
    }
    else if(section == "mathc")
    {
        return "数学计算器"
    }
    else
    {
        return section
    }
}

func getLevel(level: String) -> String
{
    if(level == "E")
    {
        return "简单"
    }
    else if(level == "M")
    {
        return "中等"
    }
    else
    {
        return "困难"
    }
}
