//
//  UIView+Extension.swift
//  HouDaAnalysis
//
//  Created by 波 on 2017/11/1.
//  Copyright © 2017年 厚大经分. All rights reserved.
//

import UIKit

class HD_MonthModel: HD_BaseModel {
    
    var startTime :String?
    
    var endTime :String?
}



extension Date{
      //返回一个作为参数的字符串
     func toParamStr() -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy:MM:dd"
        let timeStr = fmt.string(from: self)
    
        return timeStr;
    }
    
    /// 比较两个日期是否是同一天
    func isSameDay(_ otherDay:Date) -> Bool{
        
        let calendar = Calendar.current
        
        let comp1 = calendar.dateComponents([Calendar.Component.year, Calendar.Component.month,Calendar.Component.day], from: self)
        
        let comp2 = calendar.dateComponents([Calendar.Component.year, Calendar.Component.month,Calendar.Component.day], from: otherDay)
        
        return comp1.day == comp2.day && comp1.month == comp2.month  && comp1.year == comp2.year;
    }
    
    
    
    /// 时间戳转时间
    func timeStampTransformDate(_ timeStamp :CLongLong) -> String {
        
        //时间戳
//        let timeSt = timeStamp // (timeStamp as NSString).integerValue
//        HDlog("时间戳：\(timeSt)")
        
        //转换为时间
        let timeInterval:TimeInterval = TimeInterval(timeStamp / 1000)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        
        //格式化输出
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        HDlog("对应的日期时间：\(dformatter.string(from: date as Date))")
    
        return dformatter.string(from: date as Date)
    }
    
    
    
    /// 时间转时间戳
    func dateTransformTimeStam(_ date: Date) -> CLongLong {
        
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        HDlog("当前日期时间：\(dformatter.string(from: date))")
        
        //当前时间的时间戳
        let timeInterval:TimeInterval = date.timeIntervalSince1970
//        let timeStamp = Int(timeInterval)
        
        let millisecond = CLongLong(round(timeInterval*1000))
        
        return millisecond
    }
    
    
    
    static func getCurrentMonthTime() -> HD_MonthModel {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let model = HD_MonthModel()
        
        let startDate = startOfCurrentMonth()
        model.startTime = dateFormatter.string(from: startDate as Date)
        
        let endDate1 = endOfCurrentMonth()
        model.endTime = dateFormatter.string(from: endDate1)
        
        return model
    }

    //本月开始日期
    static func startOfCurrentMonth() -> Date {
        let date = Date()
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(Set<Calendar.Component>([.year, .month]), from: date)
        let startOfMonth = calendar.date(from: components)!
        return startOfMonth
    }
    
    //本月结束日期
    static func endOfCurrentMonth(returnEndTime:Bool = false) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
        
        let endOfMonth =  calendar.date(byAdding: components, to: startOfCurrentMonth())!
        return endOfMonth
    }
}


