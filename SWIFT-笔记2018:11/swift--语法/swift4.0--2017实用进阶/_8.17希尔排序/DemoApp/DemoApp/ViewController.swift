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
        var step: Int = list.count / 2
        while step >= 1
        {
            for i in 0..<list.count
            {
                var j = i + step
                while j >= step && j < list.count
                {
                    if list[j] < list[j - step]
                    {
                        weak var weak_self = self
                        DispatchQueue.main.async
                        {
                            let view1 = weak_self?.view.viewWithTag(j+1)
                            let view2 = weak_self?.view.viewWithTag(j-step+1)
                            
                            let posX1 = view1?.frame.origin.x
                            let posX2 = view2?.frame.origin.x
                            
                            view1?.frame.origin.x = posX2!
                            view2?.frame.origin.x = posX1!
                            
                            view1?.tag = j-step+1
                            view2?.tag = j+1
                            
                            let temp = list[j]
                            list[j] = list[j-step]
                            list[j-step] = temp
                            
                            j = j - step
                        }
                        Thread.sleep(forTimeInterval: 0.01)
                    }
                    else
                    {
                        break
                    }
                }
            }
            step = step / 2
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

