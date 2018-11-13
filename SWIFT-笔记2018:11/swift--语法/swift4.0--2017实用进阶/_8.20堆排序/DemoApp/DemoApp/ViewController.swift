//
//  ViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/10/12.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

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
            self.sort(items: self.result)
            
            let endDate = Date()
            print(endDate.timeIntervalSince(self.date))
        }
    }
    
    func sort(items: Array<Int>)
    {
        var list = items
        var endIndex = items.count - 1
        
        var i = items.count
        while i > 0
        {
            heapAdjast(items: &list, startIndex: i - 1, endIndex:items.count )
            i -= 1
        }
        
        while endIndex >= 0
        {
            let temp = list[0]
            list[0] = list[endIndex]
            list[endIndex] = temp
            
            self.udpateView(j: 0, height: list[0])
            self.udpateView(j: endIndex, height: list[endIndex])
            
            endIndex -= 1
            
            heapAdjast(items: &list, startIndex: 0,endIndex: endIndex + 1)
        }
    }

    func heapCreate(items: inout Array<Int>)
    {
        var i = items.count
        while i > 0
        {
            heapAdjast(items: &items, startIndex: i - 1, endIndex:items.count )
            i -= 1
        }
    }
    
    func heapAdjast(items: inout Array<Int>, startIndex: Int, endIndex: Int)
    {
        let temp = items[startIndex]
        var fatherIndex = startIndex + 1
        var maxChildIndex = 2 * fatherIndex
        while maxChildIndex <= endIndex
        {
            if maxChildIndex < endIndex && items[maxChildIndex-1] < items[maxChildIndex]
            {
                maxChildIndex = maxChildIndex + 1
            }
            
            if temp < items[maxChildIndex-1]
            {
                items[fatherIndex-1] = items[maxChildIndex-1]
                self.udpateView(j: fatherIndex-1, height: items[fatherIndex-1])
            }
            else
            {
                break
            }
            
            fatherIndex = maxChildIndex
            maxChildIndex = 2 * fatherIndex
        }
        items[fatherIndex-1] = temp
        self.udpateView(j: fatherIndex-1, height: items[fatherIndex-1])
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

