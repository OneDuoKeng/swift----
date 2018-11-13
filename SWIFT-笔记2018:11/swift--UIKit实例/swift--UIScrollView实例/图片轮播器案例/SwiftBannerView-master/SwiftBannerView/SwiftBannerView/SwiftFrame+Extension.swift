
//  Frame+Extension.swift
//  Swift-Device
//
//  Created by LuKane on 2018/2/11.
//  Copyright © 2018年 LuKane. All rights reserved.
//
/**
 * 使用 SwiftBannerView的过程中,有任何bug或问题,都可以在github上提出 issue
 * 或者 联系QQ: 1169604556
 * Github: https://github.com/LuKane
 */
import Foundation

import UIKit


// MARK: - UIView + Frame Extension
extension UIView {
    
    /* X */
    public var x : CGFloat {
        get {
            return self.frame.origin.x
        }
        
        set {
            var frame = self.frame
            frame.origin.x = x
            self.frame = frame
        }
    }
    
    /* Y */
    public var y : CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set {
            var frame = self.frame
            frame.origin.y = y
            self.frame = frame
        }
    }
    
    /* Width */
    public var width : CGFloat {
        get {
            return self.frame.size.width
        }
        
        set {
            var frame = self.frame
            frame.size.width = width
            self.frame = frame
        }
    }
    
    /* Height */
    public var height : CGFloat {
        get {
            return self.frame.size.height
        }
        
        set {
            var frame = self.frame
            frame.size.height = height
            self.frame = frame
        }
    }
    
    /* Origin */
    public var origin : CGPoint {
        get {
            return self.frame.origin
        }
        
        set {
            var frame = self.frame
            frame.origin = origin
            self.frame = frame
        }
    }
    
    /* Size */
    public var size : CGSize {
        get {
            return self.frame.size
        }
        
        set {
            var frame = self.frame
            frame.size = size
            self.frame = frame
        }
    }
}

// MARK: - CALayer + Frame Extension
extension CALayer {
    /* X */
    public var x : CGFloat {
        get {
            return self.frame.origin.x
        }
        
        set {
            var frame = self.frame
            frame.origin.x = x
            self.frame = frame
        }
    }
    
    /* Y */
    public var y : CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set {
            var frame = self.frame
            frame.origin.y = y
            self.frame = frame
        }
    }
    
    /* Width */
    public var width : CGFloat {
        get {
            return self.frame.size.width
        }
        
        set {
            var frame = self.frame
            frame.size.width = width
            self.frame = frame
        }
    }
    
    /* Height */
    public var height : CGFloat {
        get {
            return self.frame.size.height
        }
        
        set {
            var frame = self.frame
            frame.size.height = height
            self.frame = frame
        }
    }
    
    /* Origin */
    public var origin : CGPoint {
        get {
            return self.frame.origin
        }
        
        set {
            var frame = self.frame
            frame.origin = origin
            self.frame = frame
        }
    }
    
    /* Size */
    public var size : CGSize {
        get {
            return self.frame.size
        }
        
        set {
            var frame = self.frame
            frame.size = size
            self.frame = frame
        }
    }
}
