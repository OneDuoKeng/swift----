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
    func quickSort(list: inout Array<Int>, low: Int, high: Int)
    {
        if low < high
        {
            let mid = partition(list: &list, low: low, high: high)
            quickSort(list: &list, low: low, high: mid - 1)
            quickSort(list: &list, low: mid + 1, high: high)
        }
    }
    
    private func partition(list: inout Array<Int>, low: Int, high: Int) -> Int {
        var low = low
        var high = high
        let temp = list[low]
        
        while low < high
        {
            while low < high && list[high] >= temp
            {
                high -= 1
            }
            list[low] = list[high]
            
            while low < high && list[low] <= temp
            {
                low += 1
            }
            
            list[high] = list[low]
        }
        list[low] = temp
        
        return low
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
            self.quickSort(list: &self.result, low: 0, high: self.result.count-1)
            
            let endDate = Date()
            print(endDate.timeIntervalSince(self.date))
        }
    }
    
    func quickSort(list: inout Array<Int>, low: Int, high: Int)
    {
        if low < high
        {
            let mid = partition(list: &list, low: low, high: high)
            quickSort(list: &list, low: low, high: mid - 1)
            quickSort(list: &list, low: mid + 1, high: high)
        }
    }
    
    private func partition(list: inout Array<Int>, low: Int, high: Int) -> Int {
        var low = low
        var high = high
        let temp = list[low]
        
        while low < high
        {
            while low < high && list[high] >= temp
            {
                high -= 1
            }
            list[low] = list[high]
            udpateView(j: low, height: list[high])
            
            while low < high && list[low] <= temp
            {
                low += 1
            }
            
            list[high] = list[low]
            udpateView(j: high, height: list[low])
        }
        list[low] = temp
        udpateView(j: low, height: temp)
        
        return low
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

