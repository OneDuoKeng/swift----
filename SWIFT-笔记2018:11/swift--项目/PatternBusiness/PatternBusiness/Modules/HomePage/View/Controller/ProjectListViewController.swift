//
//  ProjectListViewController.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/7.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit

fileprivate let projectListCell = "projectListCell"

class ProjectListViewController: UIViewController {

    var projectListViewModel = ProjectListViewModel()
    
    var listTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData(typeRefresh: .downRefresh)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

}

extension ProjectListViewController {
    func setupUI() {
        listTableView.frame = self.view.bounds
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: "ProjectListCell", bundle: nil), forCellReuseIdentifier: projectListCell)
        listTableView.rowHeight = 120*proportionWidth
        self.view.addSubview(listTableView)
        
        listTableView.es.addInfiniteScrolling {
            self.loadData(typeRefresh: .upRefresh)
        }
        
    }
    func loadData(typeRefresh:TypeRefresh) {
        self.projectListViewModel.loadProjectListData(typeRefresh: typeRefresh) {
            switch typeRefresh {
            case .downRefresh:
                self.listTableView.reloadData()
                self.listTableView.es.stopPullToRefresh()
                break
            case .upRefresh:
                if self.projectListViewModel.projectListArray.count <= page*pageSize {
                    self.listTableView.reloadData()//刷新
                    self.listTableView.es.stopLoadingMore()
                } else {
                    self.listTableView.es.noticeNoMoreData()
                }
                break
            default:
                print("不刷新")
            }
        }
    }
}

extension ProjectListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projectListViewModel.projectListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: projectListCell, for: indexPath) as! ProjectListCell
        
        cell.model = self.projectListViewModel.projectListArray[indexPath.row]
        
        return cell
    }
    
    
}
