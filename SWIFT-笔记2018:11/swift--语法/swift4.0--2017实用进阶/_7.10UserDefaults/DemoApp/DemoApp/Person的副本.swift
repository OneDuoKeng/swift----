//
//  Persion.swift
//  DemoApp
//
//  Created by Jerry on 2017/10/12.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import Foundation

class Person: NSObject, NSCoding
{
    var name: String
    
    required init(name:String="")
    {
        self.name = name
    }
    
    required init(coder decoder: NSCoder)
    {
        self.name = decoder.decodeObject(forKey: "Name") as? String ?? ""
    }
    
    func encode(with coder: NSCoder)
    {
        coder.encode(name, forKey:"Name")
    }
}
