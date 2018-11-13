//
//  HomePageViewController.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/5/29.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

fileprivate let reuseCell : String = "reuseCell"
fileprivate let activityListViewCell : String = "activityListViewCell"
fileprivate let courseListCell : String = "courseListCell"
fileprivate let reuseImageCell : String = "reuseImageCell"
fileprivate let teacherCell : String = "teacherCell"
fileprivate let sortingCell : String = "sortingCell"

class HomePageViewController: UIViewController {
    
    var homePageViewModel = HomePageViewModel()
    var tableView : UITableView?
    let headerView = HomePageHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadDataNow(firstLoad: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - setupUI
extension HomePageViewController {
    func setupUI() {
        navigationItem.title = "格局商学"
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib.init(nibName: "HomePageCell", bundle: nil), forCellReuseIdentifier: "homePageCell")
        tableView?.rowHeight = 240 * proportionWidth
        tableView?.backgroundColor = UIColor.white
        tableView?.sectionHeaderHeight = 40*proportionWidth;
        tableView?.sectionFooterHeight = 0.00001
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(tableView!)
        
        tableView?.register(UINib.init(nibName: "ReuseCell", bundle: nil), forCellReuseIdentifier: reuseCell)
        tableView?.register(UINib.init(nibName: "ActivityListViewCell", bundle: nil), forCellReuseIdentifier: activityListViewCell)
        tableView?.register(UINib.init(nibName: "CourseListCell", bundle: nil), forCellReuseIdentifier: courseListCell)
        tableView?.register(UINib.init(nibName: "ReuseImageCell", bundle: nil), forCellReuseIdentifier: reuseImageCell)
        tableView?.register(UINib.init(nibName: "TeacherCell", bundle: nil), forCellReuseIdentifier: teacherCell)
        tableView?.register(UINib.init(nibName: "SortingCell", bundle: nil), forCellReuseIdentifier: sortingCell)
        
        headerView.scrollImageClickDelegate = self
        headerView.buttonImageClickDelegate = self
        tableView?.tableHeaderView = headerView
    }
    
}

// MARK: - 网络加载
extension HomePageViewController {
    func loadDataNow(firstLoad: Bool) {
        homePageViewModel.loadHomePageData {
            self.tableView?.reloadData()
            //头部数据
            self.headerView.dic = self.homePageViewModel.headerDic
        }
    }
}

// MARK: - tableView代理
extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.homePageViewModel.groupingArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemType : String = self.homePageViewModel.groupingArray[section].ItemType!

        let itemArray : NSArray = self.homePageViewModel.groupingArray[section].Item!
        
        if itemType == "1" {
            let classesArray = JSON(itemArray[0])["Classes"].array
            return (classesArray?.count)!
        }
        if itemType == "9" {
            let internationalArray = JSON(itemArray[0])["international"].array
            return (internationalArray?.count)!
        }
        if itemType == "2" || itemType == "3" || itemType == "4"  {
            return (itemArray.count)
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type : String = self.homePageViewModel.groupingArray[indexPath.section].ItemType!
        if type == "1" || type == "4" || type == "9" {
            return 80*proportionWidth
        }
        if type == "2" {
            return 220*proportionWidth
        }
        if type == "3" {
            return 200*proportionWidth
        }
        return 300*proportionWidth
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIButton(type: UIButtonType.roundedRect)
        view.frame = CGRect(x: 10*proportionWidth, y: 0.0, width: kScreenWidth-20*proportionWidth, height: 40*proportionWidth)
        view.backgroundColor = UIColor.white
        view.setTitle(self.homePageViewModel.groupingArray[section].title, for: UIControlState())
        view.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        view.titleLabel?.textColor = UIColor.black
        view.tag = section
        return view
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return self.homePageViewModel.groupingArray[section].title
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let itemType : String = self.homePageViewModel.groupingArray[indexPath.section].ItemType!
        
        let itemArray : NSArray = self.homePageViewModel.groupingArray[indexPath.section].Item!

        if itemType == "1" {//课程
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as! ReuseCell
            cell.classDic = JSON(itemArray[0])["Classes"].array![indexPath.row]
            cell.selectionStyle = UITableViewCellSelectionStyle.none

            return cell;
        }
        if itemType == "2" {//活动
            let cell = tableView.dequeueReusableCell(withIdentifier: activityListViewCell, for: indexPath) as! ActivityListViewCell
            cell.activityListDic = JSON(itemArray[indexPath.row])
            cell.selectionStyle = UITableViewCellSelectionStyle.none

            return cell
        }
        if itemType == "3" {//视频
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseImageCell, for: indexPath) as! ReuseImageCell
            cell.dic = JSON(itemArray[indexPath.row])
            cell.selectionStyle = UITableViewCellSelectionStyle.none

            return cell
        }
        if itemType == "4" {//师资
            let  cell = tableView.dequeueReusableCell(withIdentifier: teacherCell, for: indexPath) as! TeacherCell
            cell.dic = JSON(itemArray[indexPath.row])
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell;
        }
        if itemType == "5" {//分院
            let cell = tableView.dequeueReusableCell(withIdentifier: sortingCell, for: indexPath) as! SortingCell
            cell.dic = JSON(itemArray)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        }
        
        if itemType == "9"  {//快讯
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as! ReuseCell
            cell.reuseDic = JSON(itemArray[0])["international"].array![indexPath.row]
            cell.selectionStyle = UITableViewCellSelectionStyle.none

            return cell;
        }
        
        let identifer = "identifer"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifer)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifer)
        }
        cell?.backgroundColor = UIColor.randomColor
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemType : String = self.homePageViewModel.groupingArray[indexPath.section].ItemType!
        let itemArray : NSArray = self.homePageViewModel.groupingArray[indexPath.section].Item!

        switch itemType {
        case "9":
            let vc = VideoListViewController()
            
            vc.hidesBottomBarWhenPushed = true
            vc.title = JSON(itemArray[0])["international"].array![indexPath.row]["title"].string
            vc.special_id = JSON(itemArray[0])["international"].array![indexPath.row]["special_id"].int
            vc.view.backgroundColor = UIColor.white
            navigationController?.pushViewController(vc, animated: true)
            
            break
        default:
            print("")
        }
        
    }
    
}

extension HomePageViewController : ScrollImageClickDelegate, ButtonImageClickDelegate {
    func buttonClick(tag: Int) {
        print(tag)
        switch tag {
        case 1:
            let vc = CourseListViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.title = "课程列表"
            vc.view.backgroundColor = UIColor.white
            navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let vc = ActivityListViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.title = "活动列表"
            vc.view.backgroundColor = UIColor.white
            navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            let vc = ProjectListViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.title = "专题列表"
            vc.view.backgroundColor = UIColor.white
            navigationController?.pushViewController(vc, animated: true)
            break
        default:
            print("no tag")
        }
    }
    
    func callBack(type: String, title: String, url: String) {
        let vc = WebViewViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.urlString = url
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }
}


