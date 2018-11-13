//
//  CourseListCell.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/1.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import Kingfisher

class CourseListCell: UITableViewCell {

    @IBOutlet weak var bigImageView: UIImageView!
    
    @IBOutlet weak var titleLB: UILabel!
    
    @IBOutlet weak var timeLB: UILabel!
    
    @IBOutlet weak var descLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var model : CourseListModel! {
        didSet {
//            model
            bigImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: model.goods_img!)!))
            titleLB.text = model.goods_name
            timeLB.text = model.goods_start
            descLB.text = model.goods_summary
//            view
            bigImageView.snp.makeConstraints { (make) in
                make.width.equalTo(kScreenWidth-40*proportionWidth)
                make.height.equalTo(130*proportionWidth)
                make.top.equalTo(10*proportionWidth)
                make.left.equalTo(20*proportionWidth)
            }
            bigImageView.layer.masksToBounds = true
            bigImageView.layer.cornerRadius = 5
            
            titleLB.snp.makeConstraints { (make) in
                make.width.equalTo(kScreenWidth/2-20*proportionWidth)
                make.height.equalTo(40*proportionWidth)
                make.top.equalTo(bigImageView.snp.bottom)
                make.left.equalTo(20*proportionWidth)
            }
            titleLB.textColor = UIColor.darkGray
            titleLB.font = UIFont(name: FontNameZapfino, size: 16)
            
            timeLB.snp.makeConstraints { (make) in
                make.width.equalTo(kScreenWidth/2-20*proportionWidth)
                make.height.equalTo(40*proportionWidth)
                make.top.equalTo(bigImageView.snp.bottom)
                make.left.equalTo(titleLB.snp.right)
            }
            timeLB.textColor = UIColor.gray
            timeLB.font = UIFont(name: FontNameGeorgia, size: 14)
            
            descLB.snp.makeConstraints { (make) in
                make.width.equalTo(kScreenWidth-40*proportionWidth)
                make.height.equalTo(30*proportionWidth)
                make.top.equalTo(timeLB.snp.bottom)
                make.left.equalTo(20*proportionWidth)
            }
            descLB.textColor = UIColor.gray
            descLB.font = UIFont(name: FontNameZapfino, size: 14)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
