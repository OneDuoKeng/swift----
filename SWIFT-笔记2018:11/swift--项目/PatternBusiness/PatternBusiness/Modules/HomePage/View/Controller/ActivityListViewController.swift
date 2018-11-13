//
//  ActivityListViewController.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/5.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import ESPullToRefresh

fileprivate let activityListViewCell : String = "activityListViewCell"

class ActivityListViewController: UIViewController {

    var listTableView = UITableView()
    
    var activityListViewModel = ActivityListViewModel()
    
    var typeRefresh : TypeRefresh = .downRefresh
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData(typeRefresh: .downRefresh)//默认下拉加载
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ActivityListViewController {
    func setupUI() {
        listTableView.frame = self.view.bounds
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.rowHeight = 210*proportionWidth
        listTableView.register(UINib.init(nibName: "ActivityListViewCell", bundle: nil), forCellReuseIdentifier: activityListViewCell)
        self.view.addSubview(listTableView)
        //上拉加载
        listTableView.es.addInfiniteScrolling {
            self.loadData(typeRefresh: .upRefresh)
        }
        //下拉刷新
//        listTableView.es.addPullToRefresh {
//            self.loadData(typeRefresh: .downRefresh)
//        }
    }
    func loadData(typeRefresh:TypeRefresh){
        activityListViewModel.loadActivityListData(typeRefresh: typeRefresh) {
            if typeRefresh == .downRefresh {
                self.listTableView.reloadData()//刷新
                self.listTableView.es.stopPullToRefresh()
                return;
            }
            if self.activityListViewModel.activityListArray.count >= page * pageSize {
                self.listTableView.reloadData()//刷新
                self.listTableView.es.stopLoadingMore()
            } else {
                self.listTableView.es.noticeNoMoreData()
            }
        }
    }
}

extension ActivityListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityListViewModel.activityListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: activityListViewCell, for: indexPath) as! ActivityListViewCell
        
        cell.model = activityListViewModel.activityListArray[indexPath.row]
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WebViewViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.urlString = self.activityListViewModel.activityListArray[indexPath.row].link
        vc.title = self.activityListViewModel.activityListArray[indexPath.row].title
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
