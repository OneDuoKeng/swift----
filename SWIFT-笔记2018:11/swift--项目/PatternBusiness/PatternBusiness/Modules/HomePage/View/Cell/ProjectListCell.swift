//
//  ProjectListCell.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/7.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import Kingfisher

class ProjectListCell: UITableViewCell {
    
    @IBOutlet weak var bigImageView: UIImageView!
    
    @IBOutlet weak var titleLB: UILabel!
    
    @IBOutlet weak var descLB: UILabel!
    
    var model : ProjectListModel! {
        didSet {
//            model
            bigImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: model.img!)!))
            titleLB.text = model.title
            descLB.text = model.summary
//            view
            bigImageView.layer.masksToBounds = true
            bigImageView.layer.cornerRadius = 5
            bigImageView.snp.makeConstraints { (m) in
                m.width.equalTo(140*proportionWidth)
                m.height.equalTo(80*proportionWidth)
                m.left.equalTo(10*proportionWidth)
                m.top.equalTo(20*proportionWidth)
            }
            
            titleLB.textColor = UIColor.black
            titleLB.font = UIFont.boldSystemFont(ofSize: 16)
            titleLB.textAlignment = NSTextAlignment.left
            titleLB.snp.makeConstraints { (m) in
                m.width.equalTo(kScreenWidth-170*proportionWidth)
                m.height.equalTo(20*proportionWidth)
                m.left.equalTo(160*proportionWidth)
                m.top.equalTo(20*proportionWidth)
            }
            
            descLB.textColor = UIColor.darkGray
            descLB.font = UIFont.systemFont(ofSize: 14)
            descLB.numberOfLines = 0
            descLB.snp.makeConstraints { (m) in
                m.width.equalTo(titleLB.snp.width)
                m.height.equalTo(60*proportionWidth)
                m.left.equalTo(160*proportionWidth)
                m.top.equalTo(40*proportionWidth)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
}
