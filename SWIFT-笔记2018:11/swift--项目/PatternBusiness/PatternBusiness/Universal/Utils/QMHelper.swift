//
//  QMHelper.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/5/30.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit

class QMHelper: NSObject {
    
    class func printModelWithJson(dict:NSDictionary) {
        for keys in dict.allKeys {
            print("var \(keys) : String?\n")
        }
        print("init(jsonData: JSON) {\n")
        for keys in dict.allKeys {
            print("\(keys) = jsonData[\"\(keys)\"].stringValue\n")
        }
        print("}")
    }
    
    class func printModelWithDictionary(dict:NSDictionary) {
        for keys in dict.allKeys {
            print("var \(keys) : String?\n")
        }
        print("init(dict: [String: Any]) {\n")
        for keys in dict.allKeys {
            print("\(keys) = dict[\"\(keys)\"] as? String ?? \"\"\n")
        }
        print("}")
    }
}
