//
//  DateUtil.swift
//  DemoApp
//
//  Created by Jerry on 2017/5/5.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

import Foundation

extension Date
{
    func Year() -> Int {
        let curCalendar : Calendar = Calendar.current
        let componentYear:Int = curCalendar.component(.year, from: self)
        return componentYear
    }
    
    func Month() -> Int {
        let curCalendar : Calendar = Calendar.current
        let componentMonth:Int = curCalendar.component(.month, from: self)
        return componentMonth
    }
    
    func Day() -> Int {
        let curCalendar : Calendar = Calendar.current
        let componentDay:Int = curCalendar.component(.day, from: self)
        return componentDay
    }
    
    func Hour() -> Int {
        let curCalendar : Calendar = Calendar.current
        let componentHour:Int = curCalendar.component(.hour, from: self)
        return componentHour
    }
    
    func Minute() -> Int {
        let curCalendar : Calendar = Calendar.current
        let componentMinute:Int = curCalendar.component(.minute, from: self)
        return componentMinute
    }
    
    func Second() -> Int {
        let curCalendar : Calendar = Calendar.current
        let componentSecond:Int = curCalendar.component(.second, from: self)
        return componentSecond
    }
    
    //get short style date time string
    //11/28/15, 10:51 AM
    func toStringShort() -> String
    {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        let shortStyleStr:String = dateFormatter.string(from: self)
        return shortStyleStr
    }
    
    //get medium style date time string
    //Nov 28, 2015, 10:51:33 AM
    func toStringMedium() -> String
    {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        let mediumStyleStr:String = dateFormatter.string(from: self)
        return mediumStyleStr
    }
    
    //get long style date time string
    //November 28, 2015 at 10:51:33 AM GMT+8
    func toStringLong() -> String {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        let longStyleStr:String = dateFormatter.string(from: self)
        return longStyleStr
    }
    
    //get full style date time string
    //Saturday, November 28, 2015 at 10:51:33 AM China Standard Time
    func toStringFull() -> String
    {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        let fullStyleStr:String = dateFormatter.string(from: self)
        return fullStyleStr
    }
    
    //get date formatted string
    //2015/11/28 10:48:12
    func toString(dateFormat:String) -> String
    {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let formattedDatetimeStr:String = dateFormatter.string(from: self)
        return formattedDatetimeStr
    }
    
    //parse input date time string into NSDate
    //input: 2015/11/28 12:01:02 and yyyy/MM/dd HH:mm:ss
    //output: Optional(2015-11-28 04:01:02 +0000)
    static func fromString(datetimeStr:String, dateFormat:String) -> Date?
    {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let parsedDatetime:Date? = dateFormatter.date(from: datetimeStr)
        return parsedDatetime
    }
}
