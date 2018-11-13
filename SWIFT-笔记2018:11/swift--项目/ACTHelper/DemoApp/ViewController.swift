//
//  ViewController.swift
//  DemoApp
//
//  Created by LiFazhan on 17/1/20.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Presentation

class ViewController: PresentationController {
    
    struct BackgroundImage
    {
        let name: String
        let left: CGFloat
        let top: CGFloat
        let speed: CGFloat
        
        init(name: String, left: CGFloat, top: CGFloat, speed: CGFloat)
        {
            self.name = name
            self.left = left
            self.top = top
            self.speed = speed
        }
        
        func positionAt(_ index: Int) -> Position?
        {
            var position: Position?
            
            if index == 0 || speed != 0.0
            {
                let currentLeft = left + CGFloat(index) * speed
                position = Position(left: currentLeft, top: top)
            }
            
            return position
        }
    }
    
    lazy var leftButton: UIBarButtonItem =
        { [unowned self] in
            
            let leftButton = UIBarButtonItem(title: " ", style: .plain,
                                             target: self, action: #selector(moveBack))
            
            leftButton.setTitleTextAttributes(
                [NSForegroundColorAttributeName : UIColor.black], for: .normal)
            
            return leftButton
            }()
    
    lazy var rightButton: UIBarButtonItem =
        { [unowned self] in
            
            let rightButton = UIBarButtonItem(title: " ", style: .plain,
                                              target: self, action: #selector(moveForward))
            
            rightButton.setTitleTextAttributes(
                [NSForegroundColorAttributeName : UIColor.black], for: .normal)
            
            return rightButton
        }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        view.backgroundColor = UIColor(red:0.0, green: 172.0/255, blue: 1.0, alpha: 1.0)
        
        configureSlides()
        configureBackground()
        
        let notificationName = Notification.Name(rawValue: "gotoIndexPage")
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(gotoIndexPage(notification:)),
                                               name: notificationName, object: nil)
    }
    
    func gotoIndexPage(notification: Notification)
    {
        let storyBoard = UIStoryboard(name: "RegLogin", bundle: nil)
        let vc = storyBoard.instantiateInitialViewController()
        
        let navigationController = UINavigationController(rootViewController: vc!)
        UIApplication.shared.delegate?.window??.rootViewController = navigationController
        
        DataUtil.setShowInfo()
    }
    
    func configureSlides()
    {
        let font = UIFont(name: "HelveticaNeue", size: 22.0)!
        let color = UIColor(red: 169.0/255, green: 227.0/255, blue: 1.0, alpha: 1)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        paragraphStyle.lineSpacing = 5
        
        let attributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: paragraphStyle]
        
        let titles = [
            "一个有态度的产品，\n唯有初心和学生不可辜负！",
            "一个有温度的产品，\n常有欢乐和鼓励与你相伴！",
            "我们的责任是为你搭建，\n一座通往成功的彩虹阶梯。",
            "你需要做的就是，\n用心跟随我们的脚步，\n一步一步走向成功！",
            ""]
            .map
            { title -> Content in
                
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 550, height: 200))
                label.numberOfLines = 5
                label.attributedText = NSAttributedString(string: title, attributes: attributes)
                let position = Position(left: 0.0, top: 0.30)
                
                return Content(view: label, position: position)
        }
        
        var slides = [SlideController]()
        
        for index in 0...(titles.count - 1)
        {
            let controller = SlideController(contents: [titles[index]])
            controller.add(animations: [Content.centerTransition(forSlideContent: titles[index])])
            
            if(index == titles.count - 1)
            {
                controller.setLast()
            }
            else if(index == titles.count - 2)
            {
                controller.setPreLast()
            }
            
            slides.append(controller)
        }
        
        add(slides)
    }
    
    func configureBackground()
    {
        var hillTop: CGFloat = 0.51
        var busTop: CGFloat = 0.75
        var houseTop: CGFloat = 0.24
        var houseSpeed: CGFloat = -0.205*1.8
        var treesTop: CGFloat = 0.743
        var busSpeed: CGFloat = 0.128
        if self.view.frame.size.width == 414
        {
            hillTop = 0.46
            busTop = 0.72
            houseSpeed = -0.18*1.8
        }
        else if self.view.frame.size.width == 375
        {
            treesTop = 0.71
            hillTop = 0.46
            busTop = 0.72
            houseTop = 0.20
        }
        else if self.view.frame.size.width == 320
        {
            treesTop = 0.66
            hillTop = 0.36
            busTop = 0.66
            houseTop = 0.10
            houseSpeed = -0.26*1.8
            busSpeed = 0.116
        }
        let backgroundImages =
            [
                BackgroundImage(name: "Trees", left: 0.0, top: treesTop, speed: -0.6*1.8),
                BackgroundImage(name: "Bus", left: 0.005, top: busTop, speed: busSpeed),
                BackgroundImage(name: "Houses", left: 0.0, top: houseTop, speed: houseSpeed),
                BackgroundImage(name: "Hills", left: 0.0, top: hillTop, speed: -0.08*1.8),
                BackgroundImage(name: "Mountains", left: 0.0, top: 0.29, speed: 0.0),
                BackgroundImage(name: "Clouds", left: -0.415, top: 0.14, speed: 0.08*1.8),
                BackgroundImage(name: "Sun", left: 0.8, top: 0.07, speed: 0.0)
        ]
        
        var contents = [Content]()
        
        for backgroundImage in backgroundImages
        {
            let imageView = UIImageView(image: UIImage(named: backgroundImage.name))
            if let position = backgroundImage.positionAt(0)
            {
                contents.append(Content(view: imageView, position: position, centered: false))
            }
        }
        
        addToBackground(contents)
        
        for row in 1...5
        {
            for (column, backgroundImage) in backgroundImages.enumerated()
            {
                if let position = backgroundImage.positionAt(row), let content = contents.at(column)
                {
                    addAnimation(TransitionAnimation(content: content, destination: position, duration: 2.0, dumping: 1.0), forPage: row)
                }
            }
        }
        
        let groundView = UIView(frame: CGRect(x: 0, y: 0, width: 1024, height: 60))
        groundView.backgroundColor = UIColor(red:0.0, green: 172.0/255, blue: 1.0, alpha: 1.0)
        let groundContent = Content(view: groundView,
                                    position: Position(left: 0.0, bottom: 0.063), centered: false)
        contents.append(groundContent)
        
        addToBackground([groundContent])
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension Array
{
    func at(_ index: Int?) -> Element?
    {
        var object: Element?
        if let index = index , index >= 0 && index < endIndex
        {
            object = self[index]
        }
        
        return object
    }
}

