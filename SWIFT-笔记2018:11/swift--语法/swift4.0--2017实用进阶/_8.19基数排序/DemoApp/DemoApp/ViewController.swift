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
            self.radixSort(list: &self.result)
            
            let endDate = Date()
            print(endDate.timeIntervalSince(self.date))
        }
    }
    
    private func radixSort(list: inout Array<Int>)
    {
        var bucket: Array<Array<Int>> = []
        for _ in 0..<10
        {
            bucket.append([])
        }
        
        var maxNumber = list[0]
        for item in list
        {
            if maxNumber < item
            {
                maxNumber = item
            }
        }
        
        let maxLength = "\(maxNumber)".count
        
        for digit in 1...maxLength
        {
            for item in list
            {
                let baseNumber = fetchBaseNumber(number: item, digit: digit)
                bucket[baseNumber].append(item)
            }
            
            var index = 0
            for i in 0..<bucket.count
            {
                while !bucket[i].isEmpty
                {
                    list[index] = bucket[i].remove(at: 0)
                    self.udpateView(j: index, height: list[index])
                    index += 1
                }
            }
        }
    }
    
    func fetchBaseNumber(number: Int, digit: Int) -> Int
    {
        if digit > 0 && digit <= "\(number)".count
        {
            var numbersArray: Array<Int> = []
            for char in "\(number)".characters
            {
                numbersArray.append(Int("\(char)")!)
            }
            return numbersArray[numbersArray.count - digit]
        }
        return 0
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

