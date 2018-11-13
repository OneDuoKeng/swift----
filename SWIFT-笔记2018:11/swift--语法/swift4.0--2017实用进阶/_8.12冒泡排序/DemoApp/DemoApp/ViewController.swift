//
//  ViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/10/12.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

extension Array
{
    fileprivate mutating func swap(i:Int,j:Int)
    {
        let temp = self[i]
        self[i] = self[j]
        self[j] = temp
    }
}

extension Array where Element:Comparable
{
    mutating func bubbleSort()
    {
        for i in 0..<self.count-1
        {
            for j in (i+1...self.count-1).reversed()
            {
                if self[j] < self[j-1]
                {
                    swap(i: j, j: j-1)
                }
            }
        }
    }
}

class ViewController: UIViewController {

    var result : Array<Int> = Array<Int>()
    var date : Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var array : Array<Int> = Array<Int>()
        
        for i in 1...100
        {
            array.append(i)
        }
        
        for _ in 1...100
        {
            let temp = Int(arc4random() % UInt32(array.count))+1
            let num = array[temp-1]
            result.append(num)
            
            array.remove(at: temp-1)
        }
        
        for i in 1...100
        {
            let num = result[i-1]
            let view = SortView(frame: CGRect(x: 10+i*3, y: 200, width: 2, height: num * 2))
            view.backgroundColor = .black
            view.tag = i
            self.view.addSubview(view)
        }
        
        let bt = UIButton(frame: CGRect(x: 10, y: 340, width: 300, height: 40))
        bt.backgroundColor = .orange
        bt.setTitle("Sort", for: .normal)
        bt.addTarget(self, action: #selector(reOrderView), for: .touchUpInside)
        self.view.addSubview(bt)
    }
    
    @objc func reOrderView()
    {
        date = Date()
        
        DispatchQueue.global().async
        {
            for i in 0..<self.result.count-1
            {
                for j in (i+1...self.result.count-1).reversed()
                {
                    if self.result[j] < self.result[j-1]
                    {
                        weak var weak_self = self
                        DispatchQueue.main.async
                        {
                            let view1 = weak_self?.view.viewWithTag(j+1)
                            let view2 = weak_self?.view.viewWithTag(j)
                            
                            let posX1 = view1?.frame.origin.x
                            let posX2 = view2?.frame.origin.x
                            
                            view1?.frame.origin.x = posX2!
                            view2?.frame.origin.x = posX1!
                            
                            view1?.tag = j
                            view2?.tag = j+1
                            
                            self.result.swap(i: j, j: j-1)
                        }
                        Thread.sleep(forTimeInterval: 0.01)
                    }
                }
            }
            
            let endDate = Date()
            print(endDate.timeIntervalSince(self.date))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

