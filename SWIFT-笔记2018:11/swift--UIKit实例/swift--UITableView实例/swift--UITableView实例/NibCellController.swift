//
//  NibCellController.swift
//  YYTableView
//
//  Created by Domo on 2018/6/27.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class NibCellController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    let identifier = "NibTableViewCell"
    var tableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        tableView = UITableView(frame:CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        tableView!.delegate = self
        tableView!.dataSource = self
        self.view.addSubview(tableView!)
        // 注册nib
        let nib = UINib.init(nibName: "NibTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: identifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        return cell!
    }
    
    //返回编辑类型，滑动删除
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return UITableViewCell.EditingStyle.delete
    }
    
    //在这里修改删除按钮的文字
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "点击删除"
    }
    
    //点击删除按钮的响应方法，在这里处理删除的逻辑
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
//
//            self.dataList!.removeAtIndex(indexPath.row)
//
//            self.tableView!.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
//
        }
    }
}
