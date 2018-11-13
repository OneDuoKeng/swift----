//
//  DateUtil.swift
//  DemoApp
//
//  Created by Jerry on 2017/5/5.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import Foundation

extension Array {
    
    func distinct<E: Equatable>(_ filter: (Element) -> E) -> [Element]
    {
        var result = [Element]()
        for value in self
        {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key)
            {
                result.append(value)
            }
        }
        return result
    }
}
