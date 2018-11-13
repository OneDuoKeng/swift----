//  Created by Jerry on 2017/10/2.
//  Copyright © 2017 www.coolketang.com. All rights reserved.

class LinkedListNode
{
    var content: Int
    var nextNode: LinkedListNode?
    
    init(_ content: Int)
    {
        self.content = content
        self.nextNode = nil
    }
}

class LinkedList
{
    var head: LinkedListNode?
    var end: LinkedListNode?
    
    func appendToHead(content: Int)
    {
        if head == nil
        {
            head = LinkedListNode(content)
            end = head
        }
        else
        {
            let temporaryNode = LinkedListNode(content)
            temporaryNode.nextNode = head
            head = temporaryNode
        }
    }
    
    func appendToEnd(content: Int)
    {
        if end == nil
        {
            end = LinkedListNode(content)
            head = end
        }
        else
        {
            end?.nextNode = LinkedListNode(content)
            end = end?.nextNode
        }
    }
}
