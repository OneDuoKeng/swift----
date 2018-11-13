//
//  ActivityListViewCell.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/5.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON

class ActivityListViewCell: UITableViewCell {
    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var typeLB: UILabel!
    @IBOutlet weak var descLB: UILabel!
    @IBOutlet weak var titleLB: UILabel!
    
    var model : ActivityListModel! {
        didSet {
//            model
            bigImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: model.img!)!))
            
            if model.official == "1"{
                typeLB.isHidden = false
            } else {
                typeLB.isHidden = true
            }
            
            titleLB.text = model.title
            
            //1未开始 2进心中 3已结束
            var typeString  = ""
            if model.tag == "1" {
                typeString = "未开始"
            } else if model.tag == "2" {
                typeString = "进行中"
            } else if model.tag == "3" {
                typeString = "已结束"
            }
            
            var textString = ""
            textString = model.address! + " " + model.stime! + " " + typeString
            
            descLB.text = textString
            
            setupUI()
        }
    }
    
    var activityListDic : JSON! {
        didSet {
            
            let imgString : String = activityListDic["img"].string!
            
            bigImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: imgString)!))
            
            if activityListDic["official"].string == "1"{
                typeLB.isHidden = false
            } else {
                typeLB.isHidden = true
            }
            
            titleLB.text = activityListDic["title"].string
            
            //1未开始 2进心中 3已结束
            var typeString  = ""
            if activityListDic["tag"].string == "1" {
                typeString = "未开始"
            } else if activityListDic["tag"].string == "2" {
                typeString = "进行中"
            } else if activityListDic["tag"].string == "3" {
                typeString = "已结束"
            }
            
            var textString = ""
            textString = activityListDic["address"].string! + " " + activityListDic["stime"].string! + " " + typeString
            
            descLB.text = textString
            
            setupUI()
        }
    }
    
    func setupUI() {
        bigImageView.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenWidth-20*proportionWidth)
            make.height.equalTo(140*proportionWidth)
            make.top.equalTo(10*proportionWidth)
            make.left.equalTo(10*proportionWidth)
        }
        bigImageView.layer.masksToBounds = true
        bigImageView.layer.cornerRadius = 5
        
        titleLB.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenWidth-20*proportionWidth)
            make.height.equalTo(40*proportionWidth)
            make.top.equalTo(bigImageView.snp.bottom)
            make.left.equalTo(10*proportionWidth)
        }
        titleLB.textColor = UIColor.darkGray
        titleLB.font = UIFont(name: FontNameGeorgia, size: 16)
        
        descLB.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenWidth-20*proportionWidth)
            make.height.equalTo(20*proportionWidth)
            make.top.equalTo(titleLB.snp.bottom)
            make.left.equalTo(10*proportionWidth)
        }
        descLB.textColor = UIColor.darkGray
        descLB.font = UIFont(name: FontNameGeorgia, size: 14)
        
        typeLB.snp.makeConstraints { (make) in
            make.width.equalTo(40*proportionWidth)
            make.height.equalTo(20*proportionWidth)
            make.top.equalTo(bigImageView.snp.top)
            make.right.equalTo(bigImageView.snp.right)
        }
        typeLB.textColor = UIColor.white
        typeLB.textAlignment = NSTextAlignment.center
        typeLB.text = "官方"
        typeLB.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
