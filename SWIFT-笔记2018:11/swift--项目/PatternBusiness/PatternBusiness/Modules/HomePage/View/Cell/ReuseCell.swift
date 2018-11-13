//
//  ReuseCell.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/11.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class ReuseCell: UITableViewCell {
    
    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var descLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //课程
    var classDic : JSON! {
        didSet {
            let imgString : String = classDic["img"].string!
            bigImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: imgString)!))
            
            titleLB.text = classDic["title"].string
            
            descLB.text = classDic["time"].string
            
            setupUI()
        }
    }
    
    //快讯
    var reuseDic : JSON! {
        didSet {
            let imgString : String = reuseDic["img"].string!
            bigImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: imgString)!))
            
            titleLB.text = reuseDic["title"].string
            
            descLB.text = reuseDic["summary"].string
            
            setupUI()
        }
    }
    
    func setupUI() {
        let cgwidth : CGFloat = 423/239*proportionWidth*60
        
        bigImageView.layer.masksToBounds = true
        bigImageView.layer.cornerRadius = 5*proportionWidth/2
        bigImageView.snp.makeConstraints { (m) in
            m.width.equalTo(cgwidth)
            m.height.equalTo(proportionWidth*60)
            m.top.equalTo(10*proportionWidth)
            m.left.equalTo(10*proportionWidth)
        }
        
        titleLB.textColor = UIColor.black
        titleLB.font = UIFont(name: FontNameGeorgia, size: 15)
        titleLB.snp.makeConstraints { (m) in
            m.width.equalTo(kScreenWidth-cgwidth-30*proportionWidth)
            m.height.equalTo(20*proportionWidth)
            m.top.equalTo(10*proportionWidth)
            m.left.equalTo(cgwidth+20*proportionWidth)
        }
        
        descLB.textColor = UIColor.darkGray
        descLB.font = UIFont(name: FontNameGeorgia, size: 13)
        descLB.snp.makeConstraints { (m) in
            m.width.equalTo(kScreenWidth-cgwidth-30*proportionWidth)
            m.height.equalTo(40*proportionWidth)
            m.top.equalTo(titleLB.snp.bottom)
            m.left.equalTo(cgwidth+20*proportionWidth)
        }
        descLB.lineBreakMode = NSLineBreakMode.byTruncatingTail
        descLB.numberOfLines = 0
        descLB.sizeToFit()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
