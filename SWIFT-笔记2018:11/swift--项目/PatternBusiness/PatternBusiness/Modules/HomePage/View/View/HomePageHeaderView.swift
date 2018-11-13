//
//  HomePageHeaderView.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/6/1.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

protocol ScrollImageClickDelegate : NSObjectProtocol {
    func callBack(type: String,title: String, url: String)
}

protocol ButtonImageClickDelegate : NSObjectProtocol {
    func buttonClick(tag : Int)
}

class HomePageHeaderView: UIView {

    var adArray = [HomePageTopAdModel]()
    
    var scrollCollectionView : UICollectionView?
    
    let layout = UICollectionViewFlowLayout()
    
    weak var scrollImageClickDelegate : ScrollImageClickDelegate?
    
    weak var buttonImageClickDelegate : ButtonImageClickDelegate?
    
    let backView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 300*proportionWidth)
        setupUI()
    }
    
    var dic : NSDictionary! {
        didSet {
            print(dic)
            if let ad = dic["ad"] as? [Any] {
                for adDic in ad {
                    let adModel = HomePageTopAdModel(jsonData: JSON(adDic))
                    self.adArray.append(adModel)
                }
            }
            if  self.adArray.count > 0 {
                print(self.adArray.count)
                scrollCollectionView?.reloadData()
            }
        }
    }
    
    
    func setupUI() {
        layout.itemSize = CGSize(width: kScreenWidth-20*proportionWidth, height: 165*proportionWidth)
        layout.minimumLineSpacing = 10*proportionWidth
        layout.minimumInteritemSpacing = 10*proportionWidth
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 10*proportionWidth, 0, 10*proportionWidth)

        scrollCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 185*proportionWidth), collectionViewLayout: layout)
        scrollCollectionView?.delegate = self
        scrollCollectionView?.dataSource = self
        scrollCollectionView?.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCollectionViewCell")
        scrollCollectionView?.isPagingEnabled = false
        scrollCollectionView?.backgroundColor = UIColor.white
        scrollCollectionView?.showsHorizontalScrollIndicator = false;

        self.addSubview(scrollCollectionView!)
        
        let classImageView = UIImageView()
        classImageView.image = UIImage(named: "curriculum")
        self.addSubview(classImageView)
        
        let classLB = UILabel()
        classLB.text = "课程"
        classLB.font = UIFont(name: FontNameGeorgia, size: 15*proportionWidth)
        classLB.textAlignment = NSTextAlignment.center
        classLB.textColor = UIColor.darkGray
        self.addSubview(classLB)
        
        let classBtn = UIButton(type: UIButtonType.roundedRect)
        self.addSubview(classBtn)
        
        let activityImageView = UIImageView()
        activityImageView.image = UIImage(named: "activity")
        self.addSubview(activityImageView)
        
        let activityLB = UILabel()
        activityLB.text = "活动"
        activityLB.font = UIFont(name: FontNameGeorgia, size: 15*proportionWidth)
        activityLB.textAlignment = NSTextAlignment.center
        activityLB.textColor = UIColor.darkGray
        self.addSubview(activityLB)
        
        let activityBtn = UIButton(type: UIButtonType.roundedRect)
        self.addSubview(activityBtn)
        
        let projectImageView = UIImageView()
        projectImageView.image = UIImage(named: "special")
        self.addSubview(projectImageView)
        
        let projectLB = UILabel()
        projectLB.text = "专题"
        projectLB.font = UIFont(name: FontNameGeorgia, size: 15*proportionWidth)
        projectLB.textAlignment = NSTextAlignment.center
        projectLB.textColor = UIColor.darkGray
        self.addSubview(projectLB)
        
        let projectBtn = UIButton(type: UIButtonType.roundedRect)
        self.addSubview(projectBtn)
        
        classImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(60*proportionWidth)
            make.top.equalTo(195*proportionWidth)
            make.left.equalTo((kScreenWidth-180*proportionWidth)/4)
        }
        
        classLB.snp.makeConstraints { (make) in
            make.width.equalTo(60*proportionWidth)
            make.height.equalTo(15*proportionWidth)
            make.top.equalTo(265*proportionWidth)
            make.left.equalTo((kScreenWidth-180*proportionWidth)/4)
        }
        
        classBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(classImageView)
        }
        
        activityImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(60*proportionWidth)
            make.top.equalTo(classImageView.snp.top)
            make.center.equalTo(self.snp.center)
        }
        
        activityLB.snp.makeConstraints { (make) in
            make.width.equalTo(60*proportionWidth)
            make.height.equalTo(15*proportionWidth)
            make.top.equalTo(265*proportionWidth)
            make.left.equalTo(activityImageView.snp.left)
        }
        
        activityBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(activityImageView)
        }
        
        projectImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(60*proportionWidth)
            make.top.equalTo(classImageView.snp.top)
            make.right.equalTo(-(kScreenWidth-180*proportionWidth)/4)
        }
        
        projectLB.snp.makeConstraints { (make) in
            make.width.equalTo(60*proportionWidth)
            make.height.equalTo(15*proportionWidth)
            make.top.equalTo(265*proportionWidth)
            make.left.equalTo(projectImageView.snp.left)
        }
        
        projectBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(projectImageView)
        }
        
        classBtn.tag = 1
        activityBtn.tag = 2
        projectBtn.tag = 3
        
        classBtn.addTarget(self, action: #selector(HomePageHeaderView.btnClick(_:)), for: UIControlEvents.touchUpInside)
        activityBtn.addTarget(self, action: #selector(HomePageHeaderView.btnClick(_:)), for: UIControlEvents.touchUpInside)
        projectBtn.addTarget(self, action: #selector(HomePageHeaderView.btnClick(_:)), for: UIControlEvents.touchUpInside)
        
    }
    @objc func btnClick (_ button:UIButton) {
        buttonImageClickDelegate?.buttonClick(tag: button.tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


extension HomePageHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.adArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        if self.adArray.count > 0 {
            collectionCell.imageView.kf.setImage(with: ImageResource(downloadURL: URL(string: self.adArray[indexPath.item].pi_img!)!))
            collectionCell.imageView.contentMode = UIViewContentMode.scaleAspectFill
            collectionCell.layer.masksToBounds = true
            collectionCell.layer.cornerRadius = 5
        }
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollImageClickDelegate?.callBack(type: self.adArray[indexPath.item].pi_type!, title: self.adArray[indexPath.item].pi_name!, url: self.adArray[indexPath.item].pi_val!)
    }
}



