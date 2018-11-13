//  Created by Jerry on 2017/10/2.
//  Copyright © 2017 www.coolketang.com. All rights reserved.

import UIKit

class Stack
{
    var stack: [AnyObject]
    
    init()
    {
        stack = [AnyObject]()
    }
    
    func isEmpty() -> Bool
    {
        return stack.isEmpty
    }
    
    func size() -> Int
    {
        return stack.count
    }
    
    func push(object: AnyObject)
    {
        stack.append(object)
    }
    
    func pop() -> AnyObject?
    {
        if isEmpty()
        {
            return nil
        }
        else
        {
            return stack.removeLast()
        }
    }
}

var stack = Stack()
stack.isEmpty()
stack.push(object: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
stack.push(object: UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0))
stack.pop()

class Queue
{
    var queue: [AnyObject]
    
    init()
    {
        queue = [AnyObject]()
    }
    
    func isEmpty() -> Bool
    {
        return queue.isEmpty
    }
    
    func size() -> Int
    {
        return queue.count
    }
    
    func joinQueue(object: AnyObject)
    {
        queue.append(object)
    }
    
    func deQueue() -> AnyObject?
    {
        if isEmpty()
        {
            return nil
        }
        else
        {
            return queue.removeFirst()
        }
    }
}

var queue = Queue()
queue.isEmpty()
queue.joinQueue(object: UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0))
queue.joinQueue(object: UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0))
queue.deQueue()



