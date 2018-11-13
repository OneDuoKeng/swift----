//
//  JieXiViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/12.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class JieXiViewController: BaseViewController {
    
    var showFilter = false
    var tabType = TabType.Analysis
    
    var crtKeMu : String = ""
    var crtTiKu : String = ""
    var crtShiJuan : String = ""
    var crtShiJuanUUId : String = ""
    var questionId : String = ""
    
    var topContainer : UIView!
    var bodyContainer : UIView!
    
    var topShadow : UIView!
    var topShadowFrame : CGRect!
    
    var filterBox : ShadowView!
    var tabView : UIView!
    var tabSelectedBar : UIView!
    var filterArea : UIView!
    var upArrowBt : UIButton!
    var clearAllBt : UIButton!
    var labelFilter : UILabel!
    var labelActOrSat : UILabel!
    var labelTiKuName : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        // Do any additional setup after loading the view.
        let topGradientBgFrame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 217)
        let gradientLayer = CAGradientLayer()
        gradientLayer.position = CGPoint(x: self.view.frame.size.width/2, y: 217/2)
        gradientLayer.bounds = topGradientBgFrame
        gradientLayer.colors = [UIColor(red: 48.0/255, green: 35.0/255, blue: 174.0/255, alpha: 1.0).cgColor,
                                UIColor(red: 147.0/255, green: 83.0/255, blue: 201.0/255, alpha: 1.0).cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 1, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        topContainer = UIView(frame: topGradientBgFrame)
        topContainer.layer.insertSublayer(gradientLayer, at: 1)
        self.view.addSubview(topContainer)
        
        topContainer.layer.shadowColor = UIColor.black.cgColor
        topContainer.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        topContainer.layer.shadowOpacity = 0.45
        topContainer.layer.shadowRadius = 10
        
        self.buildFilterBar()
        self.buildTabArea()
        self.buildFilterArea()
        self.buildBodyArea()
        
        topShadowFrame = CGRect(x: 0, y: 126, width: self.widthFull, height: 5)
        topShadow = UIView(frame: topShadowFrame)
        let shadowLayer = CAGradientLayer()
        shadowLayer.position = CGPoint(x: self.view.frame.size.width/2, y: 0)
        shadowLayer.bounds = topShadowFrame
        shadowLayer.colors = [UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).cgColor,
                                UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.35).cgColor]
        
        shadowLayer.startPoint = CGPoint(x: 0, y: 1)
        shadowLayer.endPoint = CGPoint(x: 0, y: 0)
        topShadow.layer.insertSublayer(shadowLayer, at: 1)
        self.view.addSubview(topShadow)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showTabBar()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    //MARK: -
    //MARK: buildFilterBar
    func buildFilterBar()
    {
        let filterWidth = self.view.frame.size.width - 20*2
        let filterFrame = CGRect(x: 20, y: 30, width: filterWidth, height: 45)
        filterBox = ShadowView(frame: filterFrame)
        filterBox.backgroundColor = UIColor(red: 126.0/255, green: 87.0/255, blue: 194.0/255, alpha: 0.9)
        filterBox.cornerRadius = 4.0
        filterBox.shadowRadius = 2.0
        filterBox.shadowOffset = CGSize(width: 1, height: 1)
        filterBox.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 126.0/255)
        topContainer.addSubview(filterBox)
        
        let filterLabelFRame = CGRect(x: 35, y: 0, width: filterWidth, height: 45)
        labelFilter = UILabel(frame: filterLabelFRame)
        labelFilter.text = "查询解析·任何题库·任何科目"
        labelFilter.textColor = UIColor.white
        labelFilter.font = UIFont(name: "PingFang SC", size: 14)
        filterBox.addSubview(labelFilter)
        
        let zoomIcon = UIImageView(image: UIImage(named:"ZoomIcon"))
        zoomIcon.frame = CGRect(x: 12, y: 15, width: 15, height: 15)
        filterBox.addSubview(zoomIcon)
        
        let guesture = UITapGestureRecognizer(target: self, action: #selector(JieXiViewController.tapFIlterBar(_:)))
        filterBox.addGestureRecognizer(guesture)
    }
    
    func buildFilterArea()
    {
        filterArea = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0))
        filterArea.clipsToBounds = true
        self.topContainer.addSubview(filterArea)
        
        upArrowBt = UIButton(frame: CGRect(x: 20, y: 25, width: 33, height: 33))
        upArrowBt.setImage(UIImage(named:"UpArrow"), for: .normal)
        upArrowBt.addTarget(self, action: #selector(JieXiViewController.tapFIlterBar(_:)), for: .touchUpInside)
        self.filterArea.addSubview(upArrowBt)
        
        clearAllBt = UIButton(frame: CGRect(x: self.view.frame.size.width-20-56, y: 21, width: 56, height: 40))
        clearAllBt.setTitle("全部清除", for: .normal)
        clearAllBt.titleLabel?.font = UIFont(name: "PingFang SC", size: 14)
        clearAllBt.addTarget(self, action: #selector(JieXiViewController.clearFilter(_:)), for: .touchUpInside)
        self.filterArea.addSubview(clearAllBt)
        
        let filterView1 = ShadowView(frame: CGRect(x: 20, y: 68, width: self.view.frame.size.width - 20*2, height: 45))
        filterView1.backgroundColor = UIColor(red: 126.0/255, green: 87.0/255, blue: 194.0/255, alpha: 0.9)
        filterView1.cornerRadius = 4.0
        filterView1.shadowRadius = 2.0
        filterView1.shadowOffset = CGSize(width: 1, height: 1)
        filterView1.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 126.0/255)
        self.filterArea.addSubview(filterView1)
        let guesture = UITapGestureRecognizer(target: self, action: #selector(JieXiViewController.goToSelectKemu(_:)))
        filterView1.addGestureRecognizer(guesture)
        
        labelActOrSat = UILabel(frame: CGRect(x: 20, y: 0, width: filterView1.frame.size.width, height: 45))
        labelActOrSat.textColor = UIColor.white
        labelActOrSat.font = UIFont(name: "PingFang SC", size: 14)
        labelActOrSat.text = "选择科目"
        
        filterView1.addSubview(labelActOrSat)
        
        
        let filterView2 = ShadowView(frame: CGRect(x: 20, y: 123, width: self.view.frame.size.width - 20*2, height: 45))
        filterView2.backgroundColor = UIColor(red: 126.0/255, green: 87.0/255, blue: 194.0/255, alpha: 0.9)
        filterView2.cornerRadius = 4.0
        filterView2.shadowRadius = 2.0
        filterView2.shadowOffset = CGSize(width: 1, height: 1)
        filterView2.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 126.0/255)
        self.filterArea.addSubview(filterView2)
        
        let guesture2 = UITapGestureRecognizer(target: self, action: #selector(JieXiViewController.goToSelectTiKu(_:)))
        filterView2.addGestureRecognizer(guesture2)
        
        labelTiKuName = UILabel(frame: CGRect(x: 20, y: 0, width: filterView1.frame.size.width, height: 45))
        labelTiKuName.textColor = UIColor.white
        labelTiKuName.font = UIFont(name: "PingFang SC", size: 14)
        labelTiKuName.text = "选择题库"
        filterView2.addSubview(labelTiKuName)
    }
    
    func buildTabArea()
    {
        tabView = UIView(frame: CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 44))
        self.topContainer.addSubview(tabView)
        
        tabSelectedBar = UIView(frame: CGRect(x: 20, y: 42, width: 48, height: 2))
        tabSelectedBar.backgroundColor = UIColor.white
        self.tabView.addSubview(tabSelectedBar)
        
        let tabJieXi = UIButton(frame: CGRect(x: 4, y: 4, width: 80, height: 40))
        tabJieXi.backgroundColor = UIColor.clear
        tabJieXi.titleLabel?.font = UIFont(name: "PingFang SC", size: 12)
        tabJieXi.setTitle("真题解析", for: .normal)
        tabJieXi.addTarget(self, action: #selector(JieXiViewController.tabTapped(_:)), for: .touchUpInside)
        tabJieXi.tag = 1
        self.tabView.addSubview(tabJieXi)
        
        let tabDaAn = UIButton(frame: CGRect(x: 84, y: 4, width: 80, height: 40))
        tabDaAn.backgroundColor = UIColor.clear
        tabDaAn.titleLabel?.font = UIFont(name: "PingFang SC", size: 12)
        tabDaAn.setTitle("答案查询", for: .normal)
        tabDaAn.addTarget(self, action: #selector(JieXiViewController.tabTapped(_:)), for: .touchUpInside)
        tabDaAn.tag = 2
        self.tabView.addSubview(tabDaAn)
    }
    
    func buildBodyArea()
    {
        let barHeight = DataUtil.getTabBarHeight(vc: self)
        let bodyHeight = self.view.frame.size.height - 124 - barHeight
        let bodyFrame = CGRect(x: 0, y: 124, width: Int(self.view.frame.size.width), height: Int(bodyHeight))
        bodyContainer = UIView(frame:bodyFrame)
        let color = CGFloat(249.0/255)
        bodyContainer.backgroundColor = UIColor(red: color, green: color, blue: color, alpha: 1.0)
        self.view.addSubview(bodyContainer)
        
        let footBarView = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - barHeight, width: self.view.frame.size.width, height: barHeight))
        footBarView.backgroundColor = .white
        self.view.addSubview(footBarView)
        
        self.loadShiJuanList()
    }
    
    func loadShiJuanList()
    {
        if(self.crtShiJuanUUId != "")
        {
            self.loadPassageList()
            return
        }
        
        let view = HotPaperList(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.bodyContainer.frame.size.height))
        view.controller = self
        view.type = self.tabType
        view.isScrollEnabled = true
        
        var urls = Array<String>()
        var titles = Array<String>()
        
        if self.tabType == .Analysis
        {
            if self.crtKeMu == "ACT"
            {
                urls.append("\(self.baseUrl)iOS/actHot5.json")
                titles.append("ACT热门解析")
            }
            else if self.crtKeMu == "SAT"
            {
                urls.append("\(self.baseUrl)iOS/satHot5.json")
                titles.append("SAT热门解析")
            }
            else
            {
                urls.append("\(self.baseUrl)iOS/actHot5.json")
                urls.append("\(self.baseUrl)iOS/satHot5.json")
                titles.append("ACT热门解析")
                titles.append("SAT热门解析")
            }
        }
        else
        {
            if self.crtKeMu == "ACT"
            {
                urls.append("\(self.baseUrl)iOS/actHotAnswer5.json")
                titles.append("ACT热门答案")
            }
            else if self.crtKeMu == "SAT"
            {
                urls.append("\(self.baseUrl)iOS/satHotAnswer5.json")
                titles.append("SAT热门答案")
            }
            else
            {
                urls.append("\(self.baseUrl)iOS/actHotAnswer5.json")
                urls.append("\(self.baseUrl)iOS/satHotAnswer5.json")
                titles.append("ACT热门答案")
                titles.append("SAT热门答案")
            }
        }
        
        view.loadURL(urls: urls, titles: titles, parentView: self.bodyContainer)
    }
    
    func loadPassageList()
    {
        if self.tabType == .Analysis
        {
            let view = PassageList(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
            view.controller = self
            view.loadURL(url: "\(self.baseUrl)iOS/passageExplanations.json", parentView: self.bodyContainer)
        }
        else if self.tabType == .Answer
        {
            let view = PassageDaAnList(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
            view.controller = self
            view.loadURL(url: "\(self.baseUrl)iOS/passageAnswers.json", parentView: self.bodyContainer)
        }
    }
    
    func goToSelectKemu(_ gusture:UITapGestureRecognizer)
    {
        print("select kemu")
        let controller = SelectSubjectViewController()
        controller.preController = self
        if self.crtKeMu == "ACT"
        {
            controller.activeIndex = 1
        }
        else if self.crtKeMu == "SAT"
        {
            controller.activeIndex = 2
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    func goToSelectTiKu(_ gusture:UITapGestureRecognizer)
    {
        let controller = SelectPaperViewController()
        controller.preController = self
        controller.tabType = self.tabType
        controller.crtKeMu = self.crtKeMu
        controller.crtTiKu = self.crtTiKu
        controller.crtShiJua = self.crtShiJuan
        self.present(controller, animated: true, completion: nil)
    }
    
    //MARK: -
    //MARK: 交互方法
    func tabTapped(_ sender:UIButton)
    {
        if(self.tabType.rawValue != sender.tag)
        {
            if(sender.tag == 1)
            {
                UIView.beginAnimations("tabAni1", context: nil)
                tabSelectedBar.frame = CGRect(x: 20, y: 42, width: 48, height: 2)
                UIView.setAnimationDuration(0.3)
                UIView.commitAnimations()
            }
            else
            {
                UIView.beginAnimations("tabAni2", context: nil)
                tabSelectedBar.frame = CGRect(x: 100, y: 42, width: 48, height: 2)
                UIView.setAnimationDuration(0.3)
                UIView.commitAnimations()
                
            }
            self.tabType = TabType(rawValue: sender.tag)!
            
            self.loadShiJuanList()
        }
        
    }
    
    func tapFIlterBar(_ gusture:UITapGestureRecognizer)
    {
        switchFilterArea()
    }
    
    func clearFilter(_ sender:UIButton)
    {
        self.crtKeMu = ""
        self.crtTiKu = ""
        self.crtShiJuan = ""
        self.crtShiJuanUUId = ""
        self.labelFilter.text = "查询解析·任何题库·任何科目"
        self.setFilterLabel()
        
        self.switchFilterArea()
        self.loadShiJuanList()
    }
    
    func switchFilterArea()
    {
        self.showFilter = !self.showFilter
        let barHeight = DataUtil.getTabBarHeight(vc: self)
        
        if(self.showFilter)
        {
            UIView.beginAnimations("expandTop", context: nil)
            UIView.setAnimationDuration(0.3)
            let frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 217)
            self.topContainer.frame = frame
            
            let bodyHeight = self.view.frame.size.height - 217 - barHeight
            let bodyFrame = CGRect(x: 0, y: 217, width: self.view.frame.size.width, height: bodyHeight)
            self.bodyContainer.frame = bodyFrame
            
            self.tabView.frame = CGRect(x: 0, y: 173, width: self.view.frame.size.width, height: 44)
            
            self.filterArea.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 217-44)
            
            self.topShadow.frame = CGRect(x: 0, y: Int(self.topShadowFrame.origin.y) + 93, width: self.widthFull, height: Int(self.topShadowFrame.size.height))
            
            if self.crtShiJuanUUId == ""
            {
                self.bodyContainer.subviews[0].frame.size.height = self.bodyContainer.frame.size.height
            }
            else
            {
                self.bodyContainer.subviews[0].viewWithTag(100)?.frame.size.height = self.bodyContainer.frame.size.height - 85
            }
            UIView.commitAnimations()
            
            self.filterBox.isHidden = true
            self.upArrowBt.isHidden = false
            self.clearAllBt.isHidden = false
        }
        else
        {
            UIView.beginAnimations("collapseTop", context: nil)
            UIView.setAnimationDuration(0.3)
            let frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 124)
            self.topContainer.frame = frame
            
            let bodyHeight = self.view.frame.size.height - 124 - barHeight
            let bodyFrame = CGRect(x: 0, y: 124, width: self.view.frame.size.width, height: bodyHeight)
            self.bodyContainer.frame = bodyFrame
            
            self.tabView.frame = CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 44)
            
            self.filterArea.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0)
            self.topShadow.frame = self.topShadowFrame
            
            if self.crtShiJuanUUId == ""
            {
                self.bodyContainer.subviews[0].frame.size.height = self.bodyContainer.frame.size.height
            }
            else
            {
                self.bodyContainer.subviews[0].viewWithTag(100)?.frame.size.height = self.bodyContainer.frame.size.height - 85
            }
            
            UIView.commitAnimations()
            self.filterBox.isHidden = false
            self.upArrowBt.isHidden = true
            self.clearAllBt.isHidden = true
        }
    }
    
    func shiJuanItemTapped(dic:Dictionary<String, String>)
    {
        let PaperType = dic["shifJuanType"]
        let shiJuanUuid = dic["shiJuanUuid"]
        let shiJuanTitle = dic["shifJuanTitle"]
        let shiJuanKeMu = dic["shiJuanKeMu"]
        
        if(self.showFilter)
        {
            self.switchFilterArea()
        }
        
        self.crtKeMu = shiJuanKeMu!
        self.crtTiKu = PaperType!
        self.crtShiJuan = shiJuanTitle!
        self.crtShiJuanUUId = shiJuanUuid!
        self.setFilterLabel()
        
        self.bodyContainer.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        if(self.tabType == .Analysis)
        {
            self.loadPassageList()
        }
        else
        {
            self.loadPassageList()
        }
        
    }
    
    func setFilterLabel()
    {
        var type = "解析"
        if self.tabType == .Answer
        {
            type = "答案"
        }
        if(self.crtKeMu == "" && self.crtTiKu == "")
        {
            self.labelFilter.text = "查询\(type)·任何题库·任何科目"
        }
        else
        {
            if(self.crtKeMu == "" && self.crtTiKu != "")
            {
                self.labelFilter.text = "查询\(type)·\(self.crtTiKu)"
            }
            else if(self.crtKeMu != "" && self.crtTiKu == "")
            {
                self.labelFilter.text = "查询\(type)·\(self.crtKeMu)·任何题库"
            }
            else
            {
                //self.labelFilter.text = "查询\(type)·\(self.crtKeMu)·\(self.crtTiKu)"
                self.labelFilter.text = "查询\(type)·\(self.crtKeMu)·\(self.crtShiJuan)"
            }
        }
        
        if(self.crtKeMu == "")
        {
            self.labelActOrSat.text = "选择类型"
        }
        else
        {
            self.labelActOrSat.text = self.crtKeMu
        }
        
        if(self.crtTiKu == "")
        {
            self.labelTiKuName.text = "选择题库"
        }
        else
        {
            self.labelTiKuName.text = self.crtShiJuan
        }
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
        
    }
    */

}
