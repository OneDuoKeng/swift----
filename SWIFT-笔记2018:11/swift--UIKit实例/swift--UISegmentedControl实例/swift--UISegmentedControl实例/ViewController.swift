//
//  ViewController.swift
//  swift--UISegmentedControl实例
//
//  Created by 研发ios工程师 on 2018/11/9.
//  Copyright © 2018年 深圳海曼科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let segmentControl = UISegmentedControl(items:["海淘","天猫","京东","淘宝"])
        
        segmentControl.frame = CGRect(x:20,y:140,width:self.view.bounds.size.width,height:50)
        
        segmentControl.addTarget(self, action: #selector(segment), for: UIControl.Event.valueChanged)
        
        self.view.addSubview(segmentControl)
        
        segmentControl.insertSegment(withTitle: "每日优鲜", at: 4, animated: true)
        
        segmentControl.removeSegment(at: 0, animated: true)
        
        segmentControl.setWidth(40, forSegmentAt: 0)
        
        //5.拿到分段选择的分段数
        print(segmentControl.numberOfSegments)
        
        //6.设置填充颜色
        segmentControl.tintColor = UIColor.
        
    }
    //UISegmentedControl绑定方法
    
    @objc func segment(segment:UISegmentedControl) {
        
        print(segment.selectedSegmentIndex)
        
    }
}

