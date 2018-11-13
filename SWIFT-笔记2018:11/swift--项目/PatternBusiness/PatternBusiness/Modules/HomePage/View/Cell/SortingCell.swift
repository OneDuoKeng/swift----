//
//  SortingCell.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/12.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class SortingCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    @IBOutlet weak var sortingContentView: UICollectionView!
   
    let layout = UICollectionViewFlowLayout()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layout.itemSize = CGSize(width: 60*proportionWidth, height: 80*proportionWidth)
        layout.minimumLineSpacing = 5*proportionWidth
        layout.minimumInteritemSpacing = 15*proportionWidth
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.sectionInset = UIEdgeInsetsMake(10*proportionWidth, 20*proportionWidth, 10*proportionWidth, 20*proportionWidth)
        
        sortingContentView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 300*proportionWidth)
        sortingContentView.delegate = self
        sortingContentView.dataSource = self
        sortingContentView.collectionViewLayout = layout
        sortingContentView.register(UINib.init(nibName: "SortingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "sortingCollectionViewCell")
        
    }
    
    var dic : JSON! {
        didSet {
            print(dic.array?.count ?? 0)
            sortingContentView.reloadData()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (dic.array?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dic.array?[section]["item"].array?.count)!
    }
    
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sortingCollectionViewCell", for: indexPath) as! SortingCollectionViewCell

        let classroomPicsString : String = (dic.array?[indexPath.section]["item"].array?[indexPath.row]["classroom_pics"].string)!
        let classroomAreaCityString : String = (dic.array?[indexPath.section]["item"].array?[indexPath.row]["classroom_area_city"].string)!
        
        
        collectionCell.bigImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: classroomPicsString)!))
        collectionCell.bigImageView.snp.makeConstraints { (m) in
            m.width.height.equalTo(60*proportionWidth)
            m.top.left.equalTo(0)
        }
        collectionCell.backgroundColor = UIColor.randomColor
        
        collectionCell.titleLB.text = classroomAreaCityString
        collectionCell.titleLB.backgroundColor = UIColor.white
        collectionCell.titleLB.snp.makeConstraints { (m) in
            m.width.equalTo(60*proportionWidth)
            m.height.equalTo(20*proportionWidth)
            m.top.equalTo(60*proportionWidth)
            m.left.equalTo(0)
        }
        
        return collectionCell
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
