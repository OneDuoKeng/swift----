//
//  ControllerUtil.swift
//  DemoApp
//
//  Created by Jerry on 2017/5/4.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import Foundation
import UIKit

class ControllerUtil
{
    class func getTabController() -> UITabBarController
    {
        let vc1 = JieXiViewController()
        let vc2 = MySettingsViewController()
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        let tabVC = UITabBarController()
        tabVC.viewControllers = [nav1, nav2]
        tabVC.selectedIndex = 0
        tabVC.view.backgroundColor = UIColor.white
        
        let tabBar = tabVC.tabBar
        tabBar.tintColor = UIColor(red: 255.0/255, green: 89.0/255, blue: 95.0/255, alpha: 1.0)
        
        let item = tabBar.items![0]
        item.image = UIImage(named: "tabSearch")
        item.title = "发现"
        
        let item2 = tabBar.items![1]
        item2.image = UIImage(named: "tabMy")
        item2.title = "我的"
        
        return tabVC
    }
}
