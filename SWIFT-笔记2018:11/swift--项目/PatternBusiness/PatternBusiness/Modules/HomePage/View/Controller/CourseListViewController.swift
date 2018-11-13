//
//  CourseListViewController.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/1.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit

fileprivate let courseListCell : String = "courseListCell"

class CourseListViewController: UIViewController {

    var courseListViewModel = CourseListViewModel()
    
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

extension CourseListViewController {
    func setupUI() {
        listTableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib.init(nibName: "CourseListCell", bundle: nil), forCellReuseIdentifier: courseListCell)
        listTableView.rowHeight = 210*proportionWidth
        self.view.addSubview(listTableView)
        //上拉加载
        listTableView.es.addInfiniteScrolling {
            self.loadData(typeRefresh: .upRefresh)
        }
    }
}

extension CourseListViewController {
    func loadData(typeRefresh:TypeRefresh) {
        courseListViewModel.loadCourseListData(typeRefresh:typeRefresh) {
            print("接口请求完毕！！！")
            self.listTableView.reloadData()
            if self.courseListViewModel.courseListArray.count >= page * pageSize {
                self.listTableView.reloadData()//刷新
                self.listTableView.es.stopLoadingMore()
            } else {
                self.listTableView.es.noticeNoMoreData()
            }
        }
    }
}

extension CourseListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseListViewModel.courseListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: courseListCell) as! CourseListCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.model = courseListViewModel.courseListArray[indexPath.row]
        return cell
    }
    
}
