//  Created by Jerry on 2017/10/2.
//  Copyright © 2017 www.coolketang.com. All rights reserved.

import UIKit

final class SingleClass: NSObject
{
    static let shared = SingleClass()
    private override init() {}
    
    func say()
    {
        print("Hello, CoolKeTang!")
    }
}
SingleClass.shared.say()


final class SecondSingletonClass: NSObject
{
    static var shared: SecondSingletonClass
    {
        struct Static
        {
            static let instance: SecondSingletonClass = SecondSingletonClass()
        }
        return Static.instance
    }
    private override init() {}
    
    func say()
    {
        print("Hello, CoolKeTang!")
    }
}

SecondSingletonClass.shared.say()
/*
class ThirdSingletonClass
{
    class var sharedInstance : ThirdSingletonClass
    {
        struct Static
        {
            static let instance : ThirdSingletonClass = ThirdSingletonClass()
        }
        return Static.instance
    }
    
    func say()
    {
        print("Hello, CoolKeTang!")
    }
}
ThirdSingletonClass.sharedInstance.say()
*/
