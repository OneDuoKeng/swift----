//
//  TeacherCell.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/12.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class TeacherCell: UITableViewCell {

    @IBOutlet weak var bigImage: UIImageView!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var descLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var dic : JSON! {
        didSet {
            let imageUrl : String = dic["img"].string!
            bigImage.kf.setImage(with: ImageResource(downloadURL: URL(string: imageUrl)!))
            
            nameLB.text = dic["name"].string!
            titleLB.text = dic["title"].string!
            descLB.text = dic["desc"].string!
            
            setupUI()
            
        }
    }

    func setupUI() {
        bigImage.layer.cornerRadius = 5/2
        bigImage.snp.makeConstraints { (m) in
            m.width.height.equalTo(60*proportionWidth)
            m.top.equalTo(10*proportionWidth)
            m.left.equalTo(10*proportionWidth)
        }
        
        nameLB.textColor = UIColor.black
        nameLB.font = UIFont.boldSystemFont(ofSize: 15)
        nameLB.snp.makeConstraints { (m) in
            m.width.equalTo(kScreenWidth-90*proportionWidth)
            m.height.equalTo(20*proportionWidth)
            m.top.equalTo(10*proportionWidth)
            m.left.equalTo(80*proportionWidth)
        }
        
        titleLB.textColor = UIColor.darkGray
        titleLB.font = UIFont.systemFont(ofSize: 14)
        titleLB.snp.makeConstraints { (m) in
            m.width.equalTo(kScreenWidth-90*proportionWidth)
            m.height.equalTo(20*proportionWidth)
            m.top.equalTo(nameLB.snp.bottom)
            m.right.equalTo(-10*proportionWidth)
        }
        
        descLB.textColor = UIColor.gray
        descLB.font = UIFont.boldSystemFont(ofSize: 13)
        descLB.snp.makeConstraints { (m) in
            m.width.equalTo(kScreenWidth-90*proportionWidth)
            m.height.equalTo(20*proportionWidth)
            m.bottom.equalTo(-10*proportionWidth)
            m.left.equalTo(80*proportionWidth)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
