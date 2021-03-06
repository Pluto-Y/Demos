//
//  HealthKitUtil.swift
//  HealthKitTotorial
//
//  Created by ChipSea on 15/12/6.
//  Copyright © 2015年 pluto-y. All rights reserved.
//

import HealthKit

class HealthKitUtil : NSObject {
    static let store = HKHealthStore()
    
    // 获取授权
    class func authorizeHealthKit(completion: ((success:Bool, error:NSError!) -> Void)!) {
        // 1. 想要读的操作类型
        let readTypes : Set<HKObjectType> = [
            HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth)!,
            HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBloodType)!,
            HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBiologicalSex)!,
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!,
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)!,
            HKObjectType.workoutType()
            ]
        
        // 2. 想要写的操作类型
        let writeTypes : Set<HKSampleType> = [
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex)!,
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned)!,
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning)!,
            HKQuantityType.workoutType()
            ]
        
        // 3. 查看在该设备上HealthKit是否可用
        if NSClassFromString("HKHealthStore") != nil && !HKHealthStore.isHealthDataAvailable() {
            let error = NSError(domain: "com.pluto-y.healthkittotorial", code: 2, userInfo: [NSLocalizedDescriptionKey:"HealthKit在该设备上不可用"])
            if( completion != nil ) {
                completion(success:false, error:error)
            }
            return;
        }

        // 4. 获取授权
        store.requestAuthorizationToShareTypes(writeTypes, readTypes: readTypes) { (success, error) -> Void in
            if completion != nil {
                completion (success: success, error: error)
            }
        }
    }
    
    // 读取特征
    class func readCharacteristics() -> (age : Int?, biologicalSex : HKBiologicalSexObject?, booldType : HKBloodTypeObject?) {
        var age : Int? = 0
        // 读取生日
        if let birthday = try? store.dateOfBirth() {
            let today = NSDate()
            let differenceComponents = NSCalendar.currentCalendar().components([.Year], fromDate: birthday, toDate: today, options: NSCalendarOptions(rawValue: 0))
            age = differenceComponents.year
        }
        // 读取性别
        let biologicalSex : HKBiologicalSexObject? = try? store.biologicalSex()
        // 读取血型
        let bloodType : HKBloodTypeObject? = try? store.bloodType()
        print("age : \(age), biologicalSex: \(biologicalSex), bloodType: \(bloodType)")
        return (age, biologicalSex, bloodType)
    }
    
    class func readWeightAndHeight() -> (weight: Double?, height: Double?) {
        return (nil, nil)
    }
    
    class func readMostRecentData(sampleType:HKSampleType , completion: ((HKSample!, NSError!) -> Void)!) {
        
        // 1. 产生一个相对相对久远的时间到单签时间的时间段（用于读取数据的时间段）
        let timeBegin = NSDate.distantPast()
        let timeEnd   = NSDate()
        let mostRecentPredicate = HKQuery.predicateForSamplesWithStartDate(timeBegin, endDate:timeEnd, options: .None)
        
        // 2. 产生一个排列的过滤器，即按照什么来排序
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        // 3. 取的条目数，即我们要从Health Kit中取多少条数据
        let limit = 1
        
        // 4. 产生一个从Health Kit中获取数据的Query对象，HKHealthStore通过该对象进行取得符合条件的数据
        //    关于最后一个参数闭包是用于获取数据后的回调
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDescriptor])
            { (sampleQuery, results, error ) -> Void in
                
                if let _ = error { // 读取过程中出错
                    completion(nil,error)
                    return;
                }
                
                // 读取第一条数据
                let mostRecentSample = results!.first as? HKQuantitySample
                
                // 将第一条数据传给最后一个参数的闭包中
                if completion != nil {
                    completion(mostRecentSample,nil)
                }
        }
        // 5. 执行读取Health Kit的操作
        store.executeQuery(sampleQuery)
    }
    
    // 保存BMI数据点
    class func saveBMISample(bmi:Double, date:NSDate ) {
        
        // 1. 创建数据点
        let bmiType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex)
        let bmiQuantity = HKQuantity(unit: HKUnit.countUnit(), doubleValue: bmi)
        let bmiSample = HKQuantitySample(type: bmiType!, quantity: bmiQuantity, startDate: date, endDate: date)
        
        // 2. 保存数据点
        store.saveObject(bmiSample, withCompletion: { (success, error) -> Void in
            if( error != nil ) {
                print("报错BMI数据点出错 error:: \(error?.localizedDescription)")
            } else {
                print("保存BMI数据点成功!")
            }
        })
    }
    
    class func saveRunWorkout(startDate:NSDate , endDate:NSDate , distance:Double, distanceUnit:HKUnit , kiloCalories:Double,
        completion: ( (Bool, NSError!) -> Void)!) {
            
            // 1. 为距离和
            let distanceQuantity = HKQuantity(unit: distanceUnit, doubleValue: distance)
            let caloriesQuantity = HKQuantity(unit: HKUnit.kilocalorieUnit(), doubleValue: kiloCalories)
            
            // 2. 保存一个跑步记录
            let workout = HKWorkout(activityType: HKWorkoutActivityType.Running, startDate: startDate, endDate: endDate, duration: abs(endDate.timeIntervalSinceDate(startDate)), totalEnergyBurned: caloriesQuantity, totalDistance: distanceQuantity, metadata: nil)
            store.saveObject(workout, withCompletion: { (success, error) -> Void in
                if( error != nil  ) {
                    // 保存错误的时候将错误传递到调用的闭包
                    completion(success,error)
                } else {
                    // 如果保存成功的话，将建立新的相关数据到Health Kit，即存储距离和卡路里消耗的点数到Health Kit
                    let distanceSample = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning)!, quantity: distanceQuantity, startDate: startDate, endDate: endDate)
                    let caloriesSample = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned)!, quantity: caloriesQuantity, startDate: startDate, endDate: endDate)
                    
                    // 保存卡路里和距离，并且与之前的Workout相关联
                    store.addSamples([distanceSample,caloriesSample], toWorkout: workout, completion: { (success, error ) -> Void in
                        // 保存成功
                        completion(success,nil)
                    })
                }
            })
    }
    
    class func readRunningWorkOuts(completion: (([AnyObject]!, NSError!) -> Void)!) {
        
        // 1. 设置读取类型
        let predicate =  HKQuery.predicateForWorkoutsWithWorkoutActivityType(HKWorkoutActivityType.Running)
        // 2. 设置排序字段
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        // 3. 创建一个查询的Query
        let sampleQuery = HKSampleQuery(sampleType: HKWorkoutType.workoutType(), predicate: predicate, limit: 0, sortDescriptors: [sortDescriptor])
            { (sampleQuery, results, error ) -> Void in
                
                if let queryError = error {
                    print( "读取跑步数据的时候发生错误, Error: \(queryError.localizedDescription)")
                }
                completion(results,error)
        }
        // 4. 执行查询的Query
        store.executeQuery(sampleQuery)
        
    }
    
}


