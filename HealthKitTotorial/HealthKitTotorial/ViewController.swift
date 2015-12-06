//
//  ViewController.swift
//  HealthKitTotorial
//
//  Created by ChipSea on 15/12/6.
//  Copyright © 2015年 pluto-y. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Health Kit Demo"
    }


    @IBAction func authorizeHealthKitClick(sender: AnyObject) {
        HealthKitUtil.authorizeHealthKit { (success, error) -> Void in
            if !success {
                print("Error : 获取授权失败, error : \(error.localizedDescription)")
            } else {
                print("获取授权成功")
            }
        }
    }
}

