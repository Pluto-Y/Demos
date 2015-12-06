//
//  ReadAndSaveData.swift
//  HealthKitTotorial
//
//  Created by ChipSea on 15/12/6.
//  Copyright © 2015年 pluto-y. All rights reserved.
//

import UIKit
import HealthKit

class ReadAndSaveDataController : UIViewController {
    
    
    @IBOutlet var yHeightLbl: UILabel!
    @IBOutlet var yWeightLbl: UILabel!
    @IBOutlet var yBMILbl: UILabel!
    
    private var weight : HKQuantitySample?
    private var height : HKQuantitySample?
    private var bmi : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "读取和存储简单数据"
    }
    
    //读取身高和体重按钮的点击事件
    @IBAction func readHeightAndWeightClick(sender: AnyObject) {
        // --------- 体重读取 -----------
        // 1. 指明读取类型
        let dataType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!
        
        // 2. 调用工具类的方法来获取体重
        HealthKitUtil.readMostRecentData(dataType, completion: { (mostRecentWeight, error) -> Void in
            
            if( error != nil ) { //获取体重过程中出现错误
                print("读取体重过程出错  error: \(error.localizedDescription)")
                return;
            }
            
            var weightLocalizedString = "Unknow"
            // 3. 将读取到的体重信息进行处理后再显示
            self.weight = mostRecentWeight as? HKQuantitySample
            if let kilograms = self.weight?.quantity.doubleValueForUnit(HKUnit.gramUnitWithMetricPrefix(.Kilo)) {
                let weightFormatter = NSMassFormatter()
                weightFormatter.forPersonMassUse = true
                weightLocalizedString = weightFormatter.stringFromKilograms(kilograms)
            }
            
            // 4. 跟新界面上的显示
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.yWeightLbl.text = "体重：\(weightLocalizedString)"
            });
        });
        // --------- 身高读取 -----------
        // 1. 指明读取类型
        let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)!
        
        // 2. 调用工具类的方法来获取体重
        HealthKitUtil.readMostRecentData(sampleType, completion: { (mostRecentHeight, error) -> Void in
            
            if( error != nil ) {
                print("读取身高过程出错  error: \(error.localizedDescription)")
                return;
            }
            
            var heightLocalizedString = "Unknow"
            self.height = mostRecentHeight as? HKQuantitySample
            // 3. 将读取到的身高信息进行处理后再显示
            if let meters = self.height?.quantity.doubleValueForUnit(HKUnit.meterUnit()) {
                let heightFormatter = NSLengthFormatter()
                heightFormatter.forPersonHeightUse = true
                heightLocalizedString = heightFormatter.stringFromMeters(meters)
            }
            
            
            // 4. 跟新界面上的显示
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.yHeightLbl.text = "身高：\(heightLocalizedString)"
            });
        })
    }
    
    //计算BMI并存储的点击事件
    @IBAction func calAndSaveClick(sender: AnyObject) {
        if self.height != nil && self.weight != nil {
            let weightInKilograms = self.weight?.quantity.doubleValueForUnit(HKUnit.gramUnitWithMetricPrefix(.Kilo))
            let heightInMeters = self.height?.quantity.doubleValueForUnit(HKUnit.meterUnit())
            let bmi = self.calculateBMIWithWeightInKilograms(weightInKilograms!, heightInMeters: heightInMeters!)
            self.yBMILbl.text = "BMI：\(bmi!)"
            HealthKitUtil.saveBMISample(bmi!, date: NSDate())
        }
    }
    
    //计算BMI的工具方法
    func calculateBMIWithWeightInKilograms(weightInKilograms:Double, heightInMeters:Double) -> Double? {
        if heightInMeters == 0 {
            return nil;
        }
        return (weightInKilograms/(heightInMeters*heightInMeters));
    }
    
}
