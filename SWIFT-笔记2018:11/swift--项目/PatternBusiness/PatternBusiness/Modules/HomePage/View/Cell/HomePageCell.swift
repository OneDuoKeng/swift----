//
//  HomePageCell.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/5/30.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import Kingfisher

class HomePageCell: UITableViewCell {

    @IBOutlet weak var theImageView: UIImageView!
    @IBOutlet weak var officialImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var stateLB: UILabel!
    @IBOutlet weak var cityLB: UILabel!
    

    var model : HomePageModel! {
        didSet {
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
