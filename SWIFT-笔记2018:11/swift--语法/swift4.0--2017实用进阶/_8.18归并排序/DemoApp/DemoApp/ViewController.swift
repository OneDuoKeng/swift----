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
    var tempArray: Array<Array<Int>> = []
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
        tempArray.removeAll()
        for item in items
        {
            var subArray: Array<Int> = []
            subArray.append(item)
            tempArray.append(subArray)
        }
        
        while tempArray.count != 1
        {
            var i = 0
            while i < tempArray.count - 1
            {
                tempArray[i] = mergeArray(firstList: tempArray[i], secondList: tempArray[i + 1])
                tempArray.remove(at: i + 1)
                for subIndex in 0..<tempArray[i].count
                {
                    let index = self.countSubItemIndex(endIndex: i, subItemIndex: subIndex)
                    self.udpateView(j: index, height: tempArray[i][subIndex])
                }
                i = i + 1
            }
        }
    }
    
    func mergeArray(firstList: Array<Int>, secondList: Array<Int>) -> Array<Int>
    {
        var resultList: Array<Int> = []
        var firstIndex = 0
        var secondIndex = 0
        
        while firstIndex < firstList.count && secondIndex < secondList.count
        {
            if firstList[firstIndex] < secondList[secondIndex]
            {
                resultList.append(firstList[firstIndex])
                firstIndex += 1
            }
            else
            {
                resultList.append(secondList[secondIndex])
                secondIndex += 1
            }
        }
        
        while firstIndex < firstList.count
        {
            resultList.append(firstList[firstIndex])
            firstIndex += 1
        }
        
        while secondIndex < secondList.count
        {
            resultList.append(secondList[secondIndex])
            secondIndex += 1
        }
        
        return resultList
    }
    
    func countSubItemIndex(endIndex: Int, subItemIndex: Int) -> Int
    {
        var sum = 0
        for i in 0..<endIndex
        {
            sum += tempArray[i].count
        }
        return sum + subItemIndex
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

