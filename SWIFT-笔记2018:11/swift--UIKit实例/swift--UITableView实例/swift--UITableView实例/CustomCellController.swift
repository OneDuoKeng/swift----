//
//  CustomCellController.swift
//  YYTableView
//
//  Created by Domo on 2018/6/27.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class CustomCellController: UITableViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //去掉没有数据显示部分多余的分隔线
        tableView.tableFooterView =  UIView.init(frame: CGRect.zero)
        
        //将分隔线offset设为零，即将分割线拉满屏幕
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        //设置分隔线颜色
        tableView.separatorColor = UIColor.blue
    }
    
    // 分割线顶头
    //实现方法
//    override func viewDidLayoutSubviews() {
//        tableView.separatorInset = UIEdgeInsets.zero
//        tableView.layoutMargins = UIEdgeInsets.zero
//    }
//    //回调 cell回调 滚动屏幕cell将要显示的时候调用
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt     indexPath: IndexPath) {
//        cell.separatorInset = UIEdgeInsets.zero
//        cell.layoutMargins = UIEdgeInsets.zero
//    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CustomCell"
        let cell = CustomTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        /*
         1
         cell.focusStyle
         case `default`
         case custom
         2
         UITableViewCell.CellStyle
         case `default`
         
         case value1
         
         case value2
         
         case subtitle
         3
         cell.accessoryType
         case none // don't show any accessory view
         
         case disclosureIndicator // regular chevron. doesn't track
         
         case detailDisclosureButton // info button w/ chevron. tracks
         
         case checkmark // checkmark. doesn't track
         */
        
        cell.accessoryType =  UITableViewCell.AccessoryType.disclosureIndicator
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setValueForCell()
        return cell
    }
    

//    func editClick(button:UIButton)
//    {
//        button.isSelected = !button.isSelected
//        self.tableView.setEditing(button.isSelected, animated: true)
//        button.setTitle((button.isSelected ? "done" : "edit"), for: [])
//    }
    
    //MARK: 侧滑编辑必须实现实现下面两个方法 不然没反应     override
    //返回编辑类型，滑动删除
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {

        return UITableViewCell.EditingStyle.none
    }
    
    //在这里修改删除按钮的文字
//
//    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
//        return "点击删除"
//    }
    
//    多个
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{

        
        let share = UITableViewRowAction(style: .normal, title: "分享"){action, index in
            //分享处理事件的闭包
        }
        
        let delete = UITableViewRowAction(style: .normal, title: "删除"){action, index in
            //删除处理的闭包
        }
        delete.backgroundColor = UIColor.red
        
        return [delete, share]
    }
    
    //点击删除按钮的响应方法，在这里处理删除的逻辑
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            //self.dataList!.removeAtIndex(indexPath.row)
            //
            //self.tableView!.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
  
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
     Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
             Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
