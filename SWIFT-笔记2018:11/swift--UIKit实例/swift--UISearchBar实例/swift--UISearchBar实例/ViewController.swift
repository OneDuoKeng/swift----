//
//  ViewController.swift
//  swift--UISearchBar实例
//
//  Created by huMac on 2018/11/11.
//  Copyright © 2018 huMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UISearchBarDelegate,
UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    // 所有组件
    var ctrls:[String] = ["Label","Button1","Button2","Switch"]
    // 搜索匹配的结果，Table View使用这个数组作为datasource
    var ctrlsel:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 起始加载全部内容
        self.ctrlsel = self.ctrls
        //设置代理
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // 注册TableViewCell
        self.tableView.register(UITableViewCell.self,
                                     forCellReuseIdentifier: "SwiftCell")
    }
    
    // 返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ctrlsel.count
    }
    
    // 创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        // 为了提供表格显示性能，已创建完成的单元需重复使用
        let identify:String = "SwiftCell"
        // 同一形式的单元格重复使用，在声明时已注册
        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identify)
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.textLabel?.text = self.ctrlsel[indexPath.row]
        return cell
    }
    
    // 搜索代理UISearchBarDelegate方法，每次改变搜索内容时都会调用
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        // 没有搜索内容时显示全部组件
        if searchText == "" {
            self.ctrlsel = self.ctrls
        }
        else { // 匹配用户输入内容的前缀(不区分大小写)
            self.ctrlsel = []
            for ctrl in self.ctrls {
                if ctrl.lowercased().hasPrefix(searchText.lowercased()) {
                    self.ctrlsel.append(ctrl)
                }
            }
        }
        // 刷新Table View显示
        self.tableView.reloadData()
    }
    
    // 搜索代理UISearchBarDelegate方法，点击虚拟键盘上的Search按钮时触发
    /**func searchBarSearchButtonClicked(searchBar: UISearchBar) {
     searchBar.resignFirstResponder()
     }**/
}

