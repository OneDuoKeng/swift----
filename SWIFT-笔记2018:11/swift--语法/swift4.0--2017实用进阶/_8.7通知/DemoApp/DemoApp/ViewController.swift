//
//  ViewController.swift
//  DemoApp
//
//  Created by Jerry on 2017/10/12.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var nameField : CustomView!
    var passwordField : CustomView!
    var submitButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let width = Int(self.view.frame.size.width) - 40
        let height = 40
        
        nameField = CustomView(frame: CGRect(x: 20, y: 80, width: width, height: height))
        self.view.addSubview(nameField)
        
        passwordField = CustomView(frame: CGRect(x: 20, y: 140, width: width, height: height))
        self.view.addSubview(passwordField)
        
        submitButton = UIButton(frame: CGRect(x: 20, y: 240, width: width, height: height))
        submitButton.setTitle("Sumbit", for: .normal)
        submitButton.addTarget(self, action: #selector(ViewController.submitForm(_:)), for: .touchUpInside)
        submitButton.backgroundColor = .gray
        submitButton.isEnabled = false
        self.view.addSubview(submitButton)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.checkForm(_:)),
                                               name: NSNotification.Name(rawValue: "checkFormNotification"),
                                               object: nil)
    }
    
    @objc func checkForm(_ notification: Notification?)
    {
        if self.nameField.textField.text != "" && self.passwordField.textField.text != ""
        {
            self.submitButton.isEnabled = true
            submitButton.backgroundColor = .orange
        }
        else
        {
            self.submitButton.isEnabled = false
            submitButton.backgroundColor = .gray
        }
    }
    
    @objc func submitForm(_ sender:UIButton)
    {
        print("submitForm....")
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

