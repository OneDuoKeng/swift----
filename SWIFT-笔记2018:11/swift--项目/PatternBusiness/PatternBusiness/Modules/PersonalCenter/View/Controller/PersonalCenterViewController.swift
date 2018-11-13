//
//  PersonalCenterViewController.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/5/29.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit

class PersonalCenterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    var personalCenterVM = PersonalCenterViewModel()
    
    var listTableView = UITableView()
    
    var headerView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        listTableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.grouped)
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.estimatedRowHeight = 0;
        listTableView.estimatedSectionHeaderHeight = 0;
        listTableView.estimatedSectionFooterHeight = 0;
        listTableView.backgroundColor = UIColor.groupTableViewBackground
        self.view.addSubview(listTableView)
        
        let headerView = HeaderView()
        listTableView.tableHeaderView = headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return personalCenterVM.titlesArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (personalCenterVM.titlesArray[section] as AnyObject).count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "pcCell")
        if cell == nil  {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "pcCell")
        }
        let sectionArray : NSArray = personalCenterVM.titlesArray[indexPath.section] as! NSArray
        cell?.textLabel?.text = sectionArray[indexPath.row] as? String

        cell?.imageView?.image = UIImage(named: (personalCenterVM.imagesArray[indexPath.section] as! NSArray)[indexPath.row] as! String)
        
        return cell!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
