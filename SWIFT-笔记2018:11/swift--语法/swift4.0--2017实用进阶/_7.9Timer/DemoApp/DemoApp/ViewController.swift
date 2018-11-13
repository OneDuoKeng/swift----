//
//  ViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/5/12.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var appleCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let time = Timer(timeInterval: 1.0, repeats: false) { (timer) in
//            print("Timer in a block.")
//        }
//        time.fire()
//
//        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
//            print("scheduledTimer in a block.")
//        }

        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerAction(_:)), userInfo: "an apple", repeats: true)
        
    }
    
    @objc func timerAction(_ timer: Timer)
    {
        if self.appleCount == 3
        {
            timer.invalidate()
            return
        }
        
        let parameter = timer.userInfo
        print("I'm eating \(parameter!).")
        
        self.appleCount += 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

