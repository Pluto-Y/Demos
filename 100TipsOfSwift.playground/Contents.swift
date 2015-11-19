//: Playground - noun: a place where people can play

import Cocoa
import UIKit

// MARK: Tip 1:Currying 柯里化
func addTwoNumbers(a: Int)(num: Int) -> Int {
    return a + num
}

let addToFour = addTwoNumbers(4)

let result = addToFour(num: 2)



func dateFormat(format: String)(_ date: NSDate) -> String {
    let dateFormat = NSDateFormatter() // let常量定义
    dateFormat.dateFormat = format
    return dateFormat.stringFromDate(date)
}

let dateFormat_yyyyMMdd = dateFormat("yyyyMMdd")
let resutl = dateFormat_yyyyMMdd(NSDate())

let dateFormat_yyyy_MM_dd_hh_mm_ss = dateFormat("yyyy-MM-dd hh:mm:ss")
let result1 = dateFormat_yyyy_MM_dd_hh_mm_ss(NSDate())


// MARK: Tip 2: 将protocol 方法声明为mutating

//正确代码

//protocol Vehicle {
//    var numberOfWheel : Int {get}
//    var color : UIColor {get}
//    
//    mutating func changeColor()
//}
//
//struct MyCar :Vehicle {
//    let numberOfWheel = 4
//    var color = UIColor.blueColor()
//    
//    mutating func changeColor() {
//        color = UIColor.redColor()
//    }
//}

//错误演示

protocol Vehicle {
    var numberOfWheel : Int {get}
    var color : UIColor {get}
    
    func changeColor()
}

struct MyCar :Vehicle {
    let numberOfWheel = 4
    var color = UIColor.blueColor()
    
    mutating func changeColor() {
        color = UIColor.redColor()
    }
}





