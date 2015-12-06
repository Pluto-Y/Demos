//
//  ReadUserCharacteristicController.swift
//  HealthKitTotorial
//
//  Created by ChipSea on 15/12/6.
//  Copyright © 2015年 pluto-y. All rights reserved.
//

import UIKit
import HealthKit

class ReadUserCharacteristicController : UIViewController {
    
    @IBOutlet var ySexLbl: UILabel!
    @IBOutlet var yAgeLbl: UILabel!
    @IBOutlet var yBloodLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "读取用户特征"
    }
    
    /**
     读取用户属性
     */
    @IBAction func readUserCharacteristic(sender: AnyObject) {
        let (age, sex, bloodType) = HealthKitUtil.readCharacteristics()
        ySexLbl.text = "性别：\(self.biologicalSexLiteral(sex?.biologicalSex))"
        yBloodLbl.text = "血型：\(self.bloodTypeLiteral(bloodType?.bloodType))"
        yAgeLbl.text = "年龄:\(age!)"
    }
    
    /**
     工具方法：将HKBiologicalSex对象转成对应的字符串
     */
    func biologicalSexLiteral(biologicalSex:HKBiologicalSex?)->String {
        var biologicalSexText = "Unknow";
        
        if  biologicalSex != nil {
            switch( biologicalSex! )
            {
            case .Female:
                biologicalSexText = "女"
            case .Male:
                biologicalSexText = "男"
            default:
                break;
            }
        }
        return biologicalSexText;
    }
    
    /**
     工具方法：将HKBloodType对象转成对应的字符串
     */
    func bloodTypeLiteral(bloodType:HKBloodType?)->String {
        
        var bloodTypeText = "Unknow";
        
        if bloodType != nil {
            
            switch( bloodType! ) {
            case .APositive:
                bloodTypeText = "A+"
            case .ANegative:
                bloodTypeText = "A-"
            case .BPositive:
                bloodTypeText = "B+"
            case .BNegative:
                bloodTypeText = "B-"
            case .ABPositive:
                bloodTypeText = "AB+"
            case .ABNegative:
                bloodTypeText = "AB-"
            case .OPositive:
                bloodTypeText = "O+"
            case .ONegative:
                bloodTypeText = "O-"
            default:
                break;
            }
            
        }
        return bloodTypeText;
    }
}
