//
//  JieXiDetailViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/18.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
import Toaster

class JieXiDetailViewController: BaseViewController {
    
    var questionId : String!
    var pointMenu : FloatPointMenu!
    var questionType : String!
    var paperForm : String!
    var questionKemu : String!
    var questionNumber = 0
    var paperId : String!
    
    var questionTitle : UILabel!
    var daAnLabel : UILabel!
    var diffecultLevel : UILabel!
    var point1 : UILabel!
    var point2 : UILabel!
    var point3 : UILabel!
    var jieXiLabel : UITextView!
    var scrollView : UIScrollView!
    
    var pointArea : UIView!
    var jieXiArea : UIView!
    
    let baseYPointArea = 206
    let baseYJieXiArea = 436
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTitle = UILabel(frame: CGRect(x: 20, y: 82, width: self.view.frame.size.width-40, height: 28))
        questionTitle.text = ""
        questionTitle.font = self.font20
        questionTitle.textColor = UIColor.white
        self.view.addSubview(questionTitle)
        
        let frame = CGRect(x: 0, y: 140, width: self.view.frame.size.width, height: self.view.frame.size.height - 140)
        scrollView = UIScrollView(frame: frame)
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        let width = self.view.frame.size.width - 40
        let tiMuGaiYao = UILabel(frame: CGRect(x: 20, y: 30, width: width, height: 24))
        tiMuGaiYao.text = "题目概要"
        tiMuGaiYao.font = self.font17
        tiMuGaiYao.textColor = self.fontColorDarkGray
        scrollView.addSubview(tiMuGaiYao)
        
        let dis = 53
        for i in 0...2
        {
            let posY = 70 + i*dis
            let line = UIView(frame: CGRect(x: 20, y: posY, width: Int(width), height: 1))
            line.backgroundColor = self.fontColorLightGray
            scrollView.addSubview(line)
        }
        
        let benTiDaAn = UILabel(frame: CGRect(x: 20, y: 86, width: width, height: 20))
        benTiDaAn.textColor = self.fontColorDarkGray
        benTiDaAn.font = self.font14
        benTiDaAn.text = "本题答案"
        scrollView.addSubview(benTiDaAn)
        
        daAnLabel = UILabel(frame: CGRect(x: 20, y: 86, width: width, height: 20))
        daAnLabel.textColor = self.fontColorDarkGray
        daAnLabel.font = UIFont.boldSystemFont(ofSize: 14)
        daAnLabel.text = ""
        daAnLabel.textAlignment = .right
        scrollView.addSubview(daAnLabel)
        
        let nanYiDu = UILabel(frame: CGRect(x: 20, y: 139, width: width, height: 20))
        nanYiDu.textColor = self.fontColorDarkGray
        nanYiDu.font = self.font14
        nanYiDu.text = "难易度"
        scrollView.addSubview(nanYiDu)
        
        diffecultLevel = UILabel(frame: CGRect(x: 20, y: 139, width: width, height: 20))
        diffecultLevel.textColor = self.fontColorDarkGray
        diffecultLevel.font = UIFont.boldSystemFont(ofSize: 14)
        diffecultLevel.text = ""
        diffecultLevel.textAlignment = .right
        scrollView.addSubview(diffecultLevel)
        
        pointArea = UIView(frame: CGRect(x: 0, y: baseYPointArea, width: self.widthFull, height: 200))
        let zhiShiDianJieXi = UILabel(frame: CGRect(x: 20, y: 0, width: width, height: 24))
        zhiShiDianJieXi.text = "知识点解析"
        zhiShiDianJieXi.font = self.font17
        zhiShiDianJieXi.textColor = self.fontColorDarkGray
        pointArea.addSubview(zhiShiDianJieXi)
        
        let kaoDianCount = 2
        
        for i in 0...(kaoDianCount+1)
        {
            let posY = 246 - 206 + i*dis
            let line = UIView(frame: CGRect(x: 20, y: posY, width: Int(width), height: 1))
            line.backgroundColor = self.fontColorLightGray
            pointArea.addSubview(line)
        }
        
        let kaoDianFenLei = UILabel(frame: CGRect(x: 20, y: 262 - baseYPointArea, width: Int(width), height: 20))
        kaoDianFenLei.textColor = self.fontColorDarkGray
        kaoDianFenLei.font = self.font14
        kaoDianFenLei.text = "考点分类"
        pointArea.addSubview(kaoDianFenLei)
        
        point1 = UILabel(frame: CGRect(x: 20, y: 262 - baseYPointArea, width: Int(width), height: 20))
        point1.textColor = self.fontColorDarkGray
        point1.font = UIFont.boldSystemFont(ofSize: 14)
        point1.text = ""
        point1.textAlignment = .right
        pointArea.addSubview(point1)
        
        for i in 0...(kaoDianCount-1)
        {
            let kaoDian = UILabel(frame: CGRect(x: 20, y: 315 - baseYPointArea+i*dis, width: Int(width), height: 20))
            kaoDian.textColor = self.fontColorDarkGray
            kaoDian.font = self.font14
            kaoDian.text = "考点\(i+1)"
            pointArea.addSubview(kaoDian)
            
            if i == 0
            {
                point2 = UILabel(frame: CGRect(x: 20, y: 315 - baseYPointArea+i*dis, width: Int(width), height: 20))
                point2.textColor = self.fontColorDarkGray
                point2.font = UIFont.boldSystemFont(ofSize: 14)
                point2.text = ""
                point2.textAlignment = .right
                pointArea.addSubview(point2)
            }
            else if i == 1
            {
                point3 = UILabel(frame: CGRect(x: 20, y: 315 - baseYPointArea+i*dis, width: Int(width), height: 20))
                point3.textColor = self.fontColorDarkGray
                point3.font = UIFont.boldSystemFont(ofSize: 14)
                point3.text = ""
                point3.textAlignment = .right
                pointArea.addSubview(point3)
            }
        }
        scrollView.addSubview(pointArea)
        
        jieXiArea = UIView(frame: CGRect(x: 0, y: baseYJieXiArea, width: self.widthFull, height: 200))
        let wenZiJieXi = UILabel(frame: CGRect(x: 20, y: 0, width: Int(width), height: 24))
        wenZiJieXi.text = "文字解析"
        wenZiJieXi.font = self.font17
        wenZiJieXi.textColor = self.fontColorDarkGray
        jieXiArea.addSubview(wenZiJieXi)
        
        for i in 0...0
        {
            let posY = 476 - baseYJieXiArea + i*dis
            let line = UIView(frame: CGRect(x: 20, y: posY, width: Int(width), height: 1))
            line.backgroundColor = self.fontColorLightGray
            jieXiArea.addSubview(line)
        }
        
        jieXiLabel = UITextView(frame: CGRect(x: 20, y: 476 - baseYJieXiArea + 10, width: Int(width), height: 280))
        jieXiLabel.font = self.font14
        jieXiLabel.textColor = self.fontColorDarkGray
        jieXiLabel.isEditable = false
        jieXiArea.addSubview(jieXiLabel)
        
        scrollView.addSubview(jieXiArea)
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 780)
        
        pointMenu = FloatPointMenu(frame: CGRect.zero)
        pointMenu.controller = self
        pointMenu.buildUI()
        self.view.addSubview(pointMenu)
        
        self.loadData()
    }

    func loadData()
    {
        let url = "\(self.baseUrl)iOS/detailEnglish.json"
        HUD.show(.progress)
        Alamofire.request(url).responseJSON
            { response in
                debugPrint(response)
                HUD.hide(animated: true)
                if let json = response.result.value as? [String: Any]
                {
                    print(json.count)
                    let sn = json["sn"] as! String
                    let snList = sn.components(separatedBy: "-")
                    if let num2 = json["number"] as? Int
                    {
                        self.questionNumber = num2
                    }
                    let level = json["level"]
                    var correctAnswer = "无"
                    if let canswer = json["correctAnswer"] as? String
                    {
                        correctAnswer = canswer
                    }
                    let knowledgePoints = json["knowledgePoints"]
                    let explanation = json["explanation"]
                    
                    self.paperForm = snList[0]
                    let title = "\(self.questionType!) \(snList[0]) \(self.questionKemu!) 第\(self.questionNumber)题"
                    self.questionTitle.text = title
                    self.daAnLabel.text = correctAnswer
                    
                    if level != nil
                    {
                        self.diffecultLevel.text = getLevel(level: level as! String)
                    }
                    else
                    {
                        self.diffecultLevel.text = "无"
                    }
                    
                    if let points = knowledgePoints as? [String]
                    {
                        if points.count > 0
                        {
                            self.point1.text = points[0]
                        }
                        if points.count > 1
                        {
                            self.point3.text = points[1]
                        }
                        if points.count > 2
                        {
                            self.point3.text = points[2]
                        }
                    }
                    else
                    {
                        self.pointArea.isHidden = true
                        self.jieXiArea.frame.origin.y = CGFloat(self.baseYPointArea)
                        
                        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 580)
                    }
                    
                    if explanation != nil
                    {
                        var word = explanation as? String
                        word = word?.replacingOccurrences(of: "<p>", with: "")
                        word = word?.replacingOccurrences(of: "</p>", with: "")
                        self.jieXiLabel.text = word
                    }
                    else
                    {
                        self.jieXiLabel.text = "暂无解析"
                    }
                }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.hideTabBar()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "JumpQuestionViewController")
        {
            let vc = segue.destination as! JumpQuestionViewController
            vc.controller = self
        }
    }
 */

}
