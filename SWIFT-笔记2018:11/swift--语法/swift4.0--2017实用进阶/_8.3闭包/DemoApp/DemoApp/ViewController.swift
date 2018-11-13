//
//  ViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/10/12.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var animationVeiw : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer:Timer) in
//            print("Timer action...")
//        }

//        animationVeiw = UIView(frame: CGRect(x: 0, y: 40, width: 50, height: 50))
//        animationVeiw.backgroundColor = .orange
//        self.view.addSubview(animationVeiw)
//        
//        UIView.animate(withDuration: 1.0, animations: {
//            self.animationVeiw.frame = CGRect(x: 200, y: 40, width: 50, height: 50)
//        }) { (end:Bool) in
//            print("Animation done.")
//        }
//        Thread.detachNewThread {
//            print("Do something on a new thread.")
//        }
        
//        DispatchQueue.main.async {
//            print("DispatchQueue.main.async")
//        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            print("DispatchQueue.main.asyncAfter")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

