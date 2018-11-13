//
//  ViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/5/12.
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
    mutating func selectorSort() {
        
        var min = 0
        
        for i in 0..<self.count-1
        {
            min = i
            
            for j in i+1...self.count-1
            {
                if self[j] < self[min]
                {
                    min = j
                }
            }
            
            if min != i
            {
                swap(i: min, j: i)
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
        
        //self.result.selectorSort()
        //print(self.result)
    }
    
    @objc func reOrderView()
    {
        date = Date()
        DispatchQueue.global().async
        {
            self.selectorSort()
            
            let endDate = Date()
            print(endDate.timeIntervalSince(self.date))
        }
    }
    
    func selectorSort()
    {
        //print("简单选择排序")
        var list = self.result
        for i in 0..<list.count
        {
            //print("第\(i+1)轮选择，选择下标的范围为\(i)----\(list.count)")
            var j = i + 1
            var minValue = list[i]
            var minIndex = i
            
            //寻找无序部分中的最小值
            while j < list.count
            {
                if minValue > list[j]
                {
                    minValue = list[j]
                    minIndex = j
                }
                self.udpateView(j: j, height: list[j])
                j = j + 1
            }
            //print("在后半部分乱序数列中，最小值为：\(minValue), 下标为：\(minIndex)")
            //与无序表中的第一个值交换，让其成为有序表中的最后一个值
            if minIndex != i
            {
                //print("\(minValue)与\(list[i])交换")
                let temp = list[i]
                list[i] = list[minIndex]
                list[minIndex] = temp
                
                self.udpateView(j: i, height: list[i])
                self.udpateView(j: minIndex, height: list[minIndex])
            }
            //print("本轮结果为：\(list)\n")
        }
    }
    
    func udpateView(j: Int, height: Int)
    {
        weak var weak_self = self
        DispatchQueue.main.async
            {
                let view = weak_self?.view.viewWithTag(j+1)
                view?.frame.size.height = CGFloat(height*2)
                
        }
        Thread.sleep(forTimeInterval: 0.01)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

