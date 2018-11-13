//
//  ViewController.swift
//  swift--NavigationBar实例
//
//  Created by 研发ios工程师 on 2018/11/12.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载视图后进行任何其他设置。
        self.title = "第一页"
        self.view.backgroundColor = UIColor.white
        
        //设置右上角导航按钮的样式和功能
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Next",style:UIBarButtonItem.Style.plain,target:self,action:#selector(nextPage))

    }

    //按钮的点击事件
    
    @objc func nextPage(){
        
        //初始化第二个视图控制器对象
        
        let viewController = NextViewController()
        
        //将第二个视图控制器压入导航视图控制器，实现页面跳转
        
        self.navigationController?.pushViewController(viewController,animated:true)
        
    }

    //视图即将可见时执行该方法
    //        导航栏的样式设置
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        设置是否透明
        //        self.navigationController?.navigationBar.isTranslucent = false
        //        设置系统样式
        //        self.navigationController?.navigationBar.barStyle = .black
        //        设置背景颜色
        //        self.navigationController?.navigationBar.barTintColor = UIColor.orange
    }
    

}

