//
//  ReuseImageCell.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/11.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class ReuseImageCell: UITableViewCell {

    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
  
    var dic : JSON! {
        didSet {

            titleLB.text = dic["title"].string
            
            bigImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: dic["img"].string!)!))
            
            bigImageView.layer.masksToBounds = true
            bigImageView.layer.cornerRadius = 5*proportionWidth/2
            bigImageView.contentMode = UIViewContentMode.scaleAspectFill
            bigImageView.snp.makeConstraints { (m) in
                m.width.equalTo(kScreenWidth-20*proportionWidth)
                m.height.equalTo(proportionWidth*150)
                m.top.equalTo(10*proportionWidth)
                m.left.equalTo(10*proportionWidth)
            }
            
            titleLB.textColor = UIColor.black
            titleLB.font = UIFont(name: FontNameGeorgia, size: 15)
            titleLB.snp.makeConstraints { (m) in
                m.width.equalTo(kScreenWidth-20*proportionWidth)
                m.height.equalTo(40*proportionWidth)
                m.top.equalTo(bigImageView.snp.bottom)
                m.left.equalTo(10*proportionWidth)
            } 
        }
    }
    
    var model : VideoListModel! {
        didSet {
            titleLB.isHidden = true
            
            bigImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: model.pics!)!))
            
            playBtn.isHidden = false
            
            bigImageView.layer.masksToBounds = true
            bigImageView.layer.cornerRadius = 5
            bigImageView.contentMode = UIViewContentMode.scaleAspectFill
            bigImageView.snp.makeConstraints { (m) in
                m.width.equalTo(kScreenWidth-20*proportionWidth)
                m.height.equalTo(200*proportionWidth)
                m.top.left.equalTo(10*proportionWidth)
            }
            
            playBtn.backgroundColor = UIColor.white
            playBtn.layer.masksToBounds = true
            playBtn.layer.cornerRadius = 60*proportionWidth/2
            playBtn.snp.makeConstraints { (m) in
                m.width.height.equalTo(60*proportionWidth)
                m.center.equalTo(bigImageView.snp.center)
            }
        }
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
