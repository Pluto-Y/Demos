//: Playground - noun: a place where people can play

import Foundation
//import UIKit
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

protocol Vehicle {
    var numberOfWheel : Int {get}
    var color : UIColor {get}
    
    mutating func changeColor()
}

struct MyCar :Vehicle {
    let numberOfWheel = 4
    var color = UIColor.blueColor()
    
    mutating func changeColor() {
        color = UIColor.redColor()
    }
}

//错误演示

//protocol Vehicle {
//    var numberOfWheel : Int {get}
//    var color : UIColor {get}
//
//    func changeColor()
//}
//
//struct MyCar :Vehicle {
//    let numberOfWheel = 4
//    var color = UIColor.blueColor()
//
//    // 如果protocol的方法没有声明为mutating的话，继承的结构(枚举)是否添加mutating都会变异失败
//    func changeColor() {
//        color = UIColor.redColor()
//    }
//}

// MARK: Tip3: Sequence（for...in）

class ReverseGenerator : GeneratorType {
    typealias Element = Int
    
    var counter : Element
    init<T>(array : [T]) {
        self.counter = array.count - 1
    }
    
    init(start : Int) {
        self.counter = start
    }
    
    func next() -> Element? {
        return self.counter < 0 ? nil : counter--
    }
}

struct ReverseSequence<T> : SequenceType {
    var array : [T]
    
    init(array : [T]) {
        self.array = array
    }
    
    typealias Generator = ReverseGenerator
    
    func generate() -> Generator {
        return ReverseGenerator(array: array)
    }
}

let arr = [0, 1, 2, 3, 4]

for i in ReverseSequence(array: arr) {
    print("Index \(i) is \(arr[i])")
}

// MARK: Tip4: Tuple （多元组）

//旧的实现方式
func swapMe<T>(inout a: T, inout b : T) {
    let temp = a
    a = b
    b = temp
}

func swapMeNew<T>(inout a : T, inout b : T) {
    (a, b) = (b, a)
}

//如果有了多元组的话，以后对会抛出异常的方法可以直接放回是否成功以及错误信息
func doSomethingMightCauseError() -> (Bool, NSError?) {
    let success = false
    // 做一些操作， 成功结果放在success中，如果成功success为true
    if success {
        return (true ,nil)
    } else {
        return (false , NSError(domain: "SomeErrorDomain", code: 1, userInfo: nil))
    }
}

let (success, maybeError) = doSomethingMightCauseError()

if let error = maybeError {
    //发生错误的处理
}

// MARK: Tip5: @autoclosure和??操作符

func logIfTrue(predicate: ()->Bool) {
    if predicate() {
        print("True")
    }
}

//如果通过正常的闭包的话，可以这样调用
logIfTrue({return 2 > 1})

//由于是单行表达式所以可以进行再缩减
logIfTrue({2>1})

//又由于是最后一个参数，可以用尾随闭包
logIfTrue{2>1}

//而对于Swift中有自动闭包的方式
//则可以通过一下方式定义后，可以通过新的方式调用
func logIfTrueAuto(@autoclosure predicate : () -> Bool) {
    if predicate() {
        print("True")
    }
}

//定义完成后可以通过一下方式进行调用
logIfTrueAuto(2>1)

var level  : Int?
var startLevel = 1

var currentLevel = level ?? startLevel

//而对于??操作符来说的话，是Swift的一个也很有用的特性
//它符合短路的思路(大部分变成语言里的条件表达式都有短路的思路)，即左边为nil的情况下采取计算右边的表达式
//而在该书中对??进行猜测的代码如下,主要是针对自动闭包的延迟特性进行猜测的
func ??<T>(optional : T?, @autoclosure deaultValue : () -> T) -> T {
    switch optional {
    case .Some(let value):
        return value
    case .None:
        return deaultValue()
    }
}










