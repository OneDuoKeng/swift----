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
        
        let userDefault = UserDefaults.standard
        
        userDefault.set(35, forKey: "MyAge")
        userDefault.synchronize()
        print(userDefault.integer(forKey: "MyAge"))
        
        userDefault.set(78.5, forKey: "Percentage")
        userDefault.synchronize()
        print(userDefault.float(forKey: "Percentage"))
        
        userDefault.set(3.14159265, forKey: "PI")
        userDefault.synchronize()
        print(userDefault.double(forKey: "PI"))
        
        userDefault.set(true, forKey: "IsPassed")
        userDefault.synchronize()
        print(userDefault.bool(forKey: "IsPassed"))
        
        userDefault.set(URL(string:"http://www.coolketang.com")!, forKey: "URL")
        userDefault.synchronize()
        print(userDefault.url(forKey: "URL")!)
        
        userDefault.set("CoolKeTang", forKey: "Company")
        userDefault.synchronize()
        print(userDefault.string(forKey: "Company")!)
        
        userDefault.set(["Xcode","Swift"], forKey: "Languages")
        userDefault.synchronize()
        print(userDefault.array(forKey: "Languages") as! [String])
        
        userDefault.set(["Name":"Jerry"], forKey: "User")
        userDefault.synchronize()
        print(userDefault.dictionary(forKey: "User") as! [String : String])
        
        userDefault.removeObject(forKey: "User")
        userDefault.synchronize()
        print(userDefault.dictionary(forKey: "User") ?? "")
        
        let person = Person()
        person.name = "Smith"
        let personData = NSKeyedArchiver.archivedData(withRootObject: person)
        userDefault.synchronize()
        userDefault.set(personData, forKey: "Teacher")
        
        let data = userDefault.data(forKey: "Teacher")
        let teacher = NSKeyedUnarchiver.unarchiveObject(with: data!) as! Person
        print(teacher.name)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

