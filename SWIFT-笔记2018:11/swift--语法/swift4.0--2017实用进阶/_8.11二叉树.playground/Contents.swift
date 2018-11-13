//  Created by Jerry on 2017/10/2.
//  Copyright © 2017 www.coolketang.com. All rights reserved.

class BinaryTreeNode
{
    var content: Int
    var leftNode: BinaryTreeNode?
    var rightNode: BinaryTreeNode?
    
    init(_ content: Int)
    {
        self.content = content
        self.leftNode = nil
        self.rightNode = nil
    }
    
    func getMaxDepth(treeNode: BinaryTreeNode?) -> Int
    {
        guard let node = treeNode else
        {
            return 0
        }
        
        let total = max(getMaxDepth(treeNode: node.leftNode), getMaxDepth(treeNode: node.rightNode)) + 1
        return total
    }
    
    func isBinarySearchTree(treeNode: BinaryTreeNode?) -> Bool
    {
        guard let node = treeNode else
        {
            return true
        }
        
        if node.leftNode != nil && node.content <= (node.leftNode?.content)!
        {
            return false
        }
        
        if node.rightNode != nil && node.content >= (node.rightNode?.content)!
        {
            return false
        }
        
        return isBinarySearchTree(treeNode: node.leftNode) && isBinarySearchTree(treeNode: node.rightNode)
    }
}

var tree = BinaryTreeNode(10)
var treeLeft = BinaryTreeNode(3)
var treeRight = BinaryTreeNode(5)

tree.leftNode = treeLeft
tree.rightNode = treeRight
tree.getMaxDepth(treeNode: tree)
tree.isBinarySearchTree(treeNode: tree)
