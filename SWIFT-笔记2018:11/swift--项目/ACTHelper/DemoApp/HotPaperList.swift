//
//  HotJieXiList.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/13.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD

class HotPaperList: UIScrollView {
    
    let colors = [UIColor(red: 245.0/255, green: 166.0/255, blue: 35.0/255, alpha: 1.0),
                  UIColor(red: 0.0/255, green: 126.0/255, blue: 125.0/255, alpha: 1.0),
                  UIColor(red: 144.0/255, green: 19.0/255, blue: 254.0/255, alpha: 1.0),
                  UIColor(red: 74.0/255, green: 144.0/255, blue: 226.0/255, alpha: 1.0),
                  UIColor(red: 0.0/255, green: 126.0/255, blue: 125.0/255, alpha: 1.0)]
    var type = TabType.Analysis
    weak var controller : JieXiViewController!
    let itemH = 45
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func loadURL(urls : Array<String>, titles: Array<String>,parentView:UIView)
    {
        parentView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        parentView.addSubview(self)
        
        var distanceTitle = 0
        let titleWidth = Int(self.frame.size.width - 20*2)
        
        HUD.show(.progress)
        Alamofire.request(urls[0]).responseJSON
            { response in
                
                let titleLabel = UILabel(frame: CGRect(x: 20, y: distanceTitle, width: titleWidth, height: 64))
                titleLabel.text = titles[0]
                titleLabel.font = UIFont(name: "PingFang SC", size: 17)
                titleLabel.textColor = UIColor(red: 74.0/255, green: 74.0/255, blue: 74.0/255, alpha: 1.0)
                self.addSubview(titleLabel)
                
                if let json = response.result.value as? [[String: Any]]
                {
                    print(json.count)
                    
                    if self.controller.crtKeMu == "SAT"
                    {
                        self.buildSuccessArea(distanceTitle: &distanceTitle, titleWidth: titleWidth, parentView: parentView, json: json, titleLabel: titleLabel, keMu:"SAT")
                    }
                    else
                    {
                        self.buildSuccessArea(distanceTitle: &distanceTitle, titleWidth: titleWidth, parentView: parentView, json: json, titleLabel: titleLabel, keMu:"ACT")
                    }
                }
                else
                {
                    self.buildFailueArea(titleWidth: titleWidth, parentView: parentView, titleLabel: titleLabel, distanceTitle: &distanceTitle)
                }
                
                self.contentSize = CGSize(width: self.frame.size.width, height: CGFloat(distanceTitle+30))
                self.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
                
                if(urls.count > 1)
                {
                    Alamofire.request(urls[1]).responseJSON
                        { response in
                            
                            HUD.hide(animated: true)
                            distanceTitle += 10
                            let titleLabel = UILabel(frame: CGRect(x: 20, y: distanceTitle, width: titleWidth, height: 64))
                            titleLabel.text = titles[1]
                            titleLabel.font = UIFont(name: "PingFang SC", size: 17)
                            titleLabel.textColor = UIColor(red: 74.0/255, green: 74.0/255, blue: 74.0/255, alpha: 1.0)
                            self.addSubview(titleLabel)
                            
                            if let json = response.result.value as? [[String: Any]]
                            {
                                print(json.count)
                                
                                self.buildSuccessArea(distanceTitle: &distanceTitle, titleWidth: titleWidth, parentView: parentView, json: json, titleLabel: titleLabel, keMu:"SAT")
                            }
                            else
                            {
                                self.buildFailueArea(titleWidth: titleWidth, parentView: parentView, titleLabel: titleLabel, distanceTitle: &distanceTitle)
                            }
                            
                            self.contentSize = CGSize(width: self.frame.size.width, height: CGFloat(distanceTitle+30))
                            self.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
                    }
                }
        }
    }
    
    func buildSuccessArea(distanceTitle: inout Int, titleWidth:Int, parentView:UIView, json:[[String: Any]], titleLabel:UILabel, keMu: String)
    {
        distanceTitle += Int(titleLabel.frame.size.height)
        
        for j in 0 ... (json.count-1)
        {
            let object = json[j]
            let thisSubTitle = object["title"] as! String
            let color = colors[j]
            let number = object["visits"]
            let tikuType = object["origin"]  as! String
            let tiKuUUID = object["uuid"]  as! String
            
            let posY = Int(titleLabel.frame.origin.y) + Int(titleLabel.frame.size.height) + j*(itemH+20)
            let itemFrame = CGRect(x: 20, y: posY, width: titleWidth, height: itemH)
            let view = RegionItem(frame: itemFrame)
            
            let guesture = UITapGestureRecognizer(target: self, action: #selector(HotPaperList.itemTapped(_:)))
            view.addGestureRecognizer(guesture)
            
            view.setParameters(color: color, title: thisSubTitle, num: number as! Int, tiKuType: tikuType, tiKuId: tiKuUUID, keMu: keMu)
            self.addSubview(view)
            
            if(j < json.count-1)
            {
                distanceTitle += (itemH+20)
            }
            else
            {
                distanceTitle += itemH
            }
        }
        
    }
    
    func buildFailueArea(titleWidth:Int, parentView:UIView, titleLabel: UILabel, distanceTitle: inout Int)
    {
        let posY = Int(titleLabel.frame.origin.y) + 60
        let titleLabel = UILabel(frame: CGRect(x: 40, y: posY, width: titleWidth, height: 20))
        if(self.type == .Analysis)
        {
            titleLabel.text = "暂无数据"
        }
        else
        {
            titleLabel.text = "暂无数据"
        }
        titleLabel.font = UIFont(name: "PingFang SC", size: 14)
        titleLabel.textColor = self.controller.fontColorDarkGray
        self.addSubview(titleLabel)
        
        distanceTitle += 80
    }
    
    func itemTapped(_ gesture:UITapGestureRecognizer)
    {
        let view = gesture.view as! RegionItem
        let tiKuType = view.tiKuType
        let tiKuUuid = view.tiKuUuid
        let keMu = view.keMu
        
        let dic : Dictionary<String, String> = ["shiJuanKeMu":keMu!,"shifJuanType":tiKuType!,"shiJuanUuid":tiKuUuid!,"shifJuanTitle":view.titleLabel.text!]
        self.controller.shiJuanItemTapped(dic: dic)
    }
}
