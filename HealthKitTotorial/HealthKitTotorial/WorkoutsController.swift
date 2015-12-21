//
//  WorkoutsViewController.swift
//  HealthKitTotorial
//
//  Created by ChipSea on 15/12/21.
//  Copyright © 2015年 pluto-y. All rights reserved.
//

import UIKit
import HealthKit

class WorkoutsController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var workouts = [HKWorkout]()
    lazy var dateFormatter:NSDateFormatter = {
        
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        formatter.dateStyle = .MediumStyle
        return formatter;
        
    }()
    
    @IBOutlet var yWorkoutsTb: UITableView!
    
    override func viewDidLoad() {
        self.initAll()
    }
    
    /**
     初始化方法
     */
    func initAll() {
        yWorkoutsTb.delegate = self
        yWorkoutsTb.dataSource = self
        HealthKitUtil.readRunningWorkOuts{ (workoutFromHK, error) -> Void in
            if error != nil {
                print( "读取跑步数据的时候发生错误, Error: \(error.localizedDescription)")
            } else {
                self.workouts = workoutFromHK as! [HKWorkout]
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    self.yWorkoutsTb.reloadData()
                })
            }
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("workoutcell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "workoutcell")
            cell?.selectionStyle = .None
        }
        
        let workout = workouts[indexPath.row]
        cell?.textLabel?.text = "\(dateFormatter.stringFromDate(workout.startDate))"
        let distance = workout.totalDistance?.doubleValueForUnit(HKUnit.meterUnitWithMetricPrefix(HKMetricPrefix.Kilo))
        let duration = NSDateComponentsFormatter().stringFromTimeInterval(workout.duration)
        let energyBurned = workout.totalEnergyBurned!.doubleValueForUnit(HKUnit.jouleUnit())
        var workoutDetail = "距离:\(distance!) km, 耗时:\(duration!)"
        workoutDetail += ", 消耗卡路里: " + NSEnergyFormatter().stringFromJoules(energyBurned)
        cell?.detailTextLabel?.text = workoutDetail
        
        return cell!
    }
    
    
    
}