//
//  UserInfo.swift
//  DemoApp
//
//  Created by Jerry on 2017/4/25.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import UIKit
import Foundation

class UserInfo : NSObject, NSCoding {
    
    var myKeMu : PaperType = .ACT
    var isHaiWai : Bool = false
    var phone : String = ""
    var email : String = ""
    var password : String = ""
    var nickname : String = ""
    var verifyCode : String = ""
    var avatar : UIImage = UIImage()
    var isTested : Bool = false
    
    var head_img : String = ""
    var grade : Int = 1
    var birthday = ""
    var id = 0
    var sex = 0
    var teacher = ""
    var exam_type = 0
    var status = 0
    
    var current_score : Int = 0             //相当于服务器中的current_score
    var english : Int = 0           //相当于服务器中的english
    var math : Int = 0      //相当于服务器中的math
    var reading : Int = 0           //相当于服务器中的reading
    var science : Int = 0           //相当于服务器中的science
    var writing : Int = 0           //相当于服务器中的writing
    
    var expect_english : Int = 0
    var expect_reading : Int = 0
    var expect_science : Int = 0
    var expect_score : Int = 0
    var expect_writing : Int = 0
    var expect_math : Int = 0
    
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(self.phone, forKey: "phone")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.password, forKey: "password")
        aCoder.encode(self.nickname, forKey: "nickname")
        aCoder.encode(self.isTested, forKey: "isTested")
        
        aCoder.encode(self.head_img, forKey: "head_img")
        aCoder.encode(self.grade, forKey: "grade")
        aCoder.encode(self.birthday, forKey: "birthday")
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.sex, forKey: "sex")
        aCoder.encode(self.teacher, forKey: "teacher")
        aCoder.encode(self.exam_type, forKey: "exam_type")
        aCoder.encode(self.status, forKey: "status")
        
        aCoder.encode(self.current_score, forKey: "current_score")
        aCoder.encode(self.english, forKey: "english")
        aCoder.encode(self.math, forKey: "math")
        aCoder.encode(self.reading, forKey: "reading")
        aCoder.encode(self.science, forKey: "science")
        aCoder.encode(self.writing, forKey: "writing")
        
        aCoder.encode(self.expect_english, forKey: "expect_english")
        aCoder.encode(self.expect_reading, forKey: "expect_reading")
        aCoder.encode(self.expect_science, forKey: "expect_science")
        aCoder.encode(self.expect_score, forKey: "expect_score")
        aCoder.encode(self.expect_writing, forKey: "expect_writing")
        aCoder.encode(self.expect_math, forKey: "expect_math")
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init()
        
        self.phone = aDecoder.decodeObject(forKey: "phone") as! String
        self.email = aDecoder.decodeObject(forKey: "email") as! String
        self.password = aDecoder.decodeObject(forKey: "password") as! String
        self.nickname = aDecoder.decodeObject(forKey: "nickname") as! String
        self.nickname = aDecoder.decodeObject(forKey: "nickname") as! String
        
        self.head_img = aDecoder.decodeObject(forKey: "head_img") as! String
        self.grade = aDecoder.decodeInteger(forKey: "grade")
        self.birthday = aDecoder.decodeObject(forKey: "birthday") as! String
        self.id = aDecoder.decodeInteger(forKey: "id")
        self.sex = aDecoder.decodeInteger(forKey: "sex")
        self.teacher = aDecoder.decodeObject(forKey: "teacher") as! String
        self.exam_type = aDecoder.decodeInteger(forKey: "exam_type")
        self.status = aDecoder.decodeInteger(forKey: "status")
        
        self.current_score = aDecoder.decodeInteger(forKey: "current_score")
        self.english = aDecoder.decodeInteger(forKey: "english")
        self.math = aDecoder.decodeInteger(forKey: "math")
        self.reading = aDecoder.decodeInteger(forKey: "reading")
        self.science = aDecoder.decodeInteger(forKey: "science")
        self.writing = aDecoder.decodeInteger(forKey: "writing")
        
        self.expect_english = aDecoder.decodeInteger(forKey: "expect_english")
        self.expect_reading = aDecoder.decodeInteger(forKey: "expect_reading")
        self.expect_science = aDecoder.decodeInteger(forKey: "expect_science")
        self.expect_score = aDecoder.decodeInteger(forKey: "expect_score")
        self.expect_writing = aDecoder.decodeInteger(forKey: "expect_writing")
        self.expect_math = aDecoder.decodeInteger(forKey: "expect_math")
        
        
    }
    
    override init()
    {
        
    }
    
    func setScore(num:Int, score:Int)
    {
        switch num {
            case 0:
                self.current_score = score
            case 1:
                self.english = score
            case 2:
                self.math = score
            case 3:
                self.reading = score
            case 4:
                self.science = score
            default: break
            
        }
    }
    
    func setSATScore(num:Int, score:Int)
    {
        switch num {
        case 0:
            self.reading = score
        case 1:
            self.math = score
        case 2:
            self.writing = score
        default: break
            
        }
    }
}
