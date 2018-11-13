//
//  PassageDaAnList.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/13.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
import Toaster

struct DaAnItem {
    var number : Int
    var answer : String
}

class PassageDaAnList: UIView {
    
    var jsonData : [String: Any]!
    var sections : [String]!
    var totalKeMu = 1
    var activeIndex = 1
    var keMuArea : UIView!
    var passageArea : UIScrollView!
    weak var controller : JieXiViewController!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func loadURL(url : String, parentView:UIView)
    {
        
        parentView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        parentView.addSubview(self)
        
        HUD.show(.progress)
        Alamofire.request(url).responseJSON
            { response in
                debugPrint(response)
                HUD.hide(animated: true)
                if let json = response.result.value as? [String: Any]
                {
                    self.jsonData = json
                    self.sections = Array<String>()
                    
                    var kemuList = Array<String>()
                    if json["english"] != nil
                    {
                        kemuList.append("英语")
                        self.sections.append("english")
                    }
                    if json["math"] != nil
                    {
                        kemuList.append("数学")
                        self.sections.append("math")
                    }
                    if json["reading"] != nil
                    {
                        kemuList.append("阅读")
                        self.sections.append("reading")
                    }
                    if json["science"] != nil
                    {
                        kemuList.append("科学")
                        self.sections.append("science")
                    }
                    self.totalKeMu = kemuList.count
                    
                    let totalW = self.frame.size.width - CGFloat(20*(2+kemuList.count-1))
                    let kemuWidth = Int(totalW)/kemuList.count
                    
                    self.keMuArea = UIView(frame: CGRect(x: 0, y: 0, width: self.controller.widthFull, height: 85))
                    
                    let color = CGFloat(249.0/255)
                    self.keMuArea.backgroundColor = UIColor(red: color, green: color, blue: color, alpha: 1.0)
                    self.addSubview(self.keMuArea)
                    
                    for i in 0...kemuList.count-1
                    {
                        let disX = 20+i*(kemuWidth+20)
                        let kemuView = SubjectButton(frame:CGRect(x: disX , y: 26, width: kemuWidth, height: 45))
                        kemuView.setTitle(title: kemuList[i])
                        kemuView.tag = i + 1
                        
                        let guesture = UITapGestureRecognizer(target: self, action: #selector(PassageList.keMuTapped(_:)))
                        kemuView.addGestureRecognizer(guesture)
                        
                        if i==0
                        {
                            kemuView.active()
                        }
                        
                        self.keMuArea.addSubview(kemuView)
                    }
                    
                    self.passageArea = UIScrollView(frame: CGRect(x: 0, y: 95, width: self.frame.size.width, height: self.frame.size.height))
                    self.passageArea.isScrollEnabled = true
                    self.passageArea.tag = 100
                    self.addSubview(self.passageArea)
                    
                    let passageList = self.getPassageListByKeMu(keMu: self.sections[0])
                    
                    self.buildPassageList(passageList: passageList, parentView: parentView)
                }
                else
                {
                    
                    ToastView.appearance().font = self.controller.font14
                    ToastView.appearance().bottomOffsetPortrait = 100
                    Toast(text: "暂无数据").show()
                }
        }
    }
    
    func getPassageListByKeMu(keMu:String) -> Array<Array<DaAnItem>>
    {
        let list = self.jsonData[keMu] as? [[String: Any]]
        var arr = Array<DaAnItem>()
        for i in 0...(list?.count)!-1
        {
            if let item = list?[i]
            {
                let number = item["number"] as! Int
                var correctAnswer = ""
                if let answer = item["correctAnswer"] as? String
                {
                    correctAnswer = answer
                }
                let daAn = DaAnItem(number: number, answer: correctAnswer)
                arr.append(daAn)
            }
        }
        var result = Array<Array<DaAnItem>>()
        result.append(arr)
        
        return result
    }
    
    func buildPassageList(passageList: Array<Array<DaAnItem>>, parentView:UIView)
    {
        self.passageArea.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        var baseTitleY = 0
        let itemDis = CGFloat(15)
        let itemWidth = (self.frame.size.width - 40 - 6*itemDis)/7
        var lastItemPosY = 0
        for i in 0...passageList.count-1
        {
            if(passageList.count > 1)
            {
                if(i > 0)
                {
                    let prevNum = passageList[i-1].count
                    baseTitleY += 20 + 20
                    let floatN = ceil(Double(prevNum) / 7.0)*Double(itemWidth*2+20)
                    baseTitleY += Int(floatN)
                }
                
                let passageLabel = UILabel(frame: CGRect(x: 20, y: baseTitleY, width: 100, height: 20))
                passageLabel.text = "Passage \(i+1)"
                passageLabel.textColor = UIColor(red: 74.0/255, green: 74.0/255, blue: 74.0/255, alpha: 1.0)
                passageLabel.font = UIFont(name: "PingFang SC", size: 14)
                self.passageArea.addSubview(passageLabel)
            }
            
            if(passageList.count == 1)
            {
                baseTitleY -= 35
            }
            let list = passageList[i]
            let pointY = baseTitleY
            var baseX = 20
            var baseY = 0
            for j in 0 ... list.count-1
            {
                let posY = Int(pointY) + 40 + Int(baseY)
                let posX = baseX + (j%7)*Int((itemWidth+itemDis))
                let item = AnswerItemView(frame: CGRect(x: CGFloat(posX), y: CGFloat(posY), width: itemWidth, height: itemWidth*2))
                lastItemPosY = posY
                item.controller = self.controller
                let num = list[j].number
                let answer = list[j].answer
                item.setParameters(seq: num, daAn: answer)
                self.passageArea.addSubview(item)
                if(j % 7 == 6)
                {
                    baseY = baseY + Int(itemWidth*2) + 20
                    baseX = 20
                }
            }
            
            if(passageList.count == 1)
            {
                baseTitleY = baseY - 140
            }
        }
        
        let contentH = CGFloat(100 + lastItemPosY)
        self.passageArea.contentSize = CGSize(width: self.frame.size.width, height: contentH+40)
        self.passageArea.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        let newFrameY = self.controller.bodyContainer.frame.size.height - 85
        self.passageArea.frame = CGRect(x: 0, y: self.passageArea.frame.origin.y, width: self.passageArea.frame.size.width, height: newFrameY)
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: contentH)
    }
    
    func keMuTapped(_ gesture:UITapGestureRecognizer)
    {
        let view = gesture.view as! SubjectButton
        if(view.tag != self.activeIndex)
        {
            let preView = self.viewWithTag(self.activeIndex) as! SubjectButton
            preView.deActive()
            view.active()
            
            self.activeIndex = view.tag
            
            let passageList = self.getPassageListByKeMu(keMu: (sections?[view.tag-1])!)
            self.buildPassageList(passageList: passageList, parentView: self.superview!)
        }
    }
    
}
