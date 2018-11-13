//
//  MainTabBarViewController.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/5/29.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = UITabBarItem.appearance()
        let attrs_Normal = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.gray]//未点击颜色
        let attrs_Select = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.darkGray]//点击后颜色
        tabBar.setTitleTextAttributes(attrs_Normal, for: .normal)
        tabBar.setTitleTextAttributes(attrs_Select, for: .selected)
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension MainTabBarViewController {
    
    fileprivate func setupUI () {
        
        let viewControllersArray : [UIViewController]  = [HomePageViewController(),AddressBookViewController(),PersonalCenterViewController()]
        
        let titlesArray = [("首页", "essence"), ("关注", "friendTrends"), ("我的", "me")]
        
        for (index, vc) in viewControllersArray.enumerated() {
            vc.title = titlesArray[index].0
            vc.tabBarItem.title = titlesArray[index].0
            vc.tabBarItem.image = UIImage(named: "tabBar_\(titlesArray[index].1)_icon")
            vc.tabBarItem.selectedImage = UIImage(named: "tabBar_\(titlesArray[index].1)_click_icon")
            let nav = UINavigationController(rootViewController: vc)
            addChildViewController(nav)
        }
    }
}
