//
//  ViewController.swift
//  swift--collectionView实例
//
//  Created by 研发ios工程师 on 2018/11/9.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit
let ScreenWidth  = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

class ViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate{

    var collectionView : UICollectionView?
    let Identifier       = "CollectionViewCell"
    let headerIdentifier = "CollectionHeaderView"
    let footIdentifier   = "CollectionFootView"
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        // 初始化
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 60, height: 60)
        //每个相邻的layout的上下间隔
        layout.minimumLineSpacing = 5
        //每个相邻layout的左右间隔
        layout.minimumInteritemSpacing = 5
        //设置垂直显示
        layout.scrollDirection = .vertical
        //设置边距
        layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        // 设置分区头视图和尾视图宽高
        layout.headerReferenceSize = CGSize.init(width: ScreenWidth, height: 80)
        layout.footerReferenceSize = CGSize.init(width: ScreenWidth, height: 80)
        
        collectionView = UICollectionView.init(frame: CGRect(x:0, y:64, width:ScreenWidth, height:400), collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        self.view.addSubview(collectionView!)
        
        // 注册cell
        collectionView?.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Identifier)
        // 注册headerView
        collectionView?.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        // 注册footView
        collectionView?.register(CollectionFootView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footIdentifier)
    }
    
    //header高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: ScreenWidth, height: 80)
    }
    //footer高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: ScreenWidth, height: 80)
    }
    
    //设定header和footer的方法，根据kind不同进行不同的判断即可
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            //element :元素
            let headerView : CollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as! CollectionHeaderView
            headerView.view.backgroundColor = UIColor.red
            headerView.label.text = "This is HeaderView"
            return headerView
        }else{
            let footView : CollectionFootView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footIdentifier, for: indexPath) as! CollectionFootView
            footView.view.backgroundColor = UIColor.purple
            footView.label.text = "This is Foot"
            return footView
        }
    }
    
    //分区个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 每个区的item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    //显示cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier, for: indexPath) as! CollectionViewCell
        cell.bgView.backgroundColor = armColor()
        cell.titleLabel.text = String(format:"%ditem",indexPath.row)
        
        ///添加长按手势///
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(cellLongPress(sender:)))
        
        longPress.minimumPressDuration = 1;
        
        longPress.numberOfTouchesRequired =  1;
        
        cell.addGestureRecognizer(longPress)
   
        return cell
    }
    
    //点击item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func armColor()->UIColor{
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    //二、在长按手势的触发方法中获取CollectionViewCell的indexPath
    @objc func cellLongPress(sender:UILongPressGestureRecognizer) {
        //获取手势在collectionView中的点
        let touchPoint = sender.location(in: self.collectionView)

        if (sender.state == UIGestureRecognizer.State.began)
        {
            let indexPath = self.collectionView?.indexPathForItem(at: touchPoint)
            if indexPath != nil {
                
                print("长安我干嘛？");
            }
        }
    }
}

