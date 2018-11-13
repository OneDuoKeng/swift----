//
//  ViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/10/12.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let width = Int(self.view.frame.size.width - 40)
        let greetingButton = UIButton(frame: CGRect(x: 20, y: 100, width: width, height: 40))
        greetingButton.setTitle("Greeting", for: .normal)
        greetingButton.backgroundColor = .orange
//        greetingButton.addTarget(self, action: #selector(ViewController.buttonTapped), for: .touchUpInside)
//        greetingButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        greetingButton.tag = 1
//        greetingButton.addTarget(self, action: #selector(buttonTappedFor(_:)), for: .touchUpInside)
//        let anotherMethod : Selector = #selector(buttonTappedFor(_:))
//        greetingButton.addTarget(self, action: anotherMethod, for: .touchUpInside)
        
//        self.view.addSubview(greetingButton)
        
//        let timerSelector = #selector(ViewController.timerAction(_:))
//        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: timerSelector, userInfo: "parameter", repeats: true)
        let newSelector = #selector(calledByController)
//        self.perform(newSelector)
//        self.perform(newSelector, with: nil, afterDelay: 2.0)
//        self.perform(newSelector, on: .main, with: nil, waitUntilDone: true)
        self.performSelector(inBackground: newSelector, with: nil)
    }
    
    @objc func buttonTapped()
    {
        print("buttonTapped")
    }
    
    @objc func buttonTappedFor(_ sender: UIButton)
    {
        let tag = sender.tag
        print("button tag: \(tag)")
    }
    
    @objc func timerAction(_ timer:Timer)
    {
        let parameter = timer.userInfo
        print(parameter ?? "")
    }
    
    @objc func calledByController()
    {
        print("calledByController")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

