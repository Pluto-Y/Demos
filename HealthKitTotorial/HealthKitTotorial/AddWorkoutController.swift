//
//  AddWorkoutTableViewController.swift
//  HKTutorial
//
//  Created by ernesto on 18/10/14.
//  Copyright (c) 2014 raywenderlich. All rights reserved.
//

import UIKit
import HealthKit

class AddWorkoutController: UITableViewController {
  
  
  
    @IBOutlet var dateCell:DatePickerCell!
    @IBOutlet var startTimeCell:DatePickerCell!
  
    @IBOutlet var durationTimeCell:NumberCell!
    @IBOutlet var caloriesCell:NumberCell!
    @IBOutlet var distanceCell:NumberCell!
    @IBOutlet var distanceLbl: UILabel!
  
  
    let kSecondsInMinute=60.0
    let kDefaultWorkoutDuration:NSTimeInterval=(1.0*60.0*60.0) // 默认一个小时
    let lengthFormatter = NSLengthFormatter()
    
    func datetimeWithDate(date:NSDate , time:NSDate) -> NSDate? {
        let currentCalendar = NSCalendar.currentCalendar()
        let dateComponents = currentCalendar.components([.Day, .Month, .Year], fromDate: date)
        let hourComponents = currentCalendar.components([.Hour, .Minute], fromDate: time)
        
        let dateWithTime = currentCalendar.dateByAddingComponents(hourComponents, toDate:currentCalendar.dateFromComponents(dateComponents)!, options:NSCalendarOptions(rawValue: 0))
        
        return dateWithTime;
    
    }
  
  
    var startDate:NSDate? {
        get {
            return datetimeWithDate(dateCell.date, time: startTimeCell.date )
        }
    }
    var endDate:NSDate? {
        get {
            let endDate = startDate?.dateByAddingTimeInterval(durationInMinutes*kSecondsInMinute)
            return endDate
        }
    }
    
    var distance:Double {
        get {
            return distanceCell.doubleValue
        }
    }
    
    
    var durationInMinutes:Double {
        get {
            return durationTimeCell.doubleValue
        }
    }
    var energyBurned:Double? {
        return caloriesCell.doubleValue
    }
    
    func updateOKButtonStatus() {
        self.navigationItem.rightBarButtonItem?.enabled = ( distanceCell.doubleValue > 0 && caloriesCell.doubleValue > 0 && distanceCell.doubleValue > 0);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateCell.inputMode = .Date
        startTimeCell.inputMode = .Time
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let endDate = NSDate()
        let startDate = endDate.dateByAddingTimeInterval(-kDefaultWorkoutDuration)
        
        dateCell.date = startDate;
        startTimeCell.date = startDate
        
        let formatter = NSLengthFormatter()
        formatter.unitStyle = .Long
        let unitString = formatter.unitStringFromValue(2.0, unit: NSLengthFormatterUnit.Kilometer)
        distanceLbl.text = "距离 (" + unitString.capitalizedString + ")"
        
        self.navigationItem.rightBarButtonItem?.enabled  = false
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    @IBAction func textFieldValueChanged(sender:AnyObject ) {
        updateOKButtonStatus()
    }
  
    
    @IBAction func cancelBtnClick(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
  
    @IBAction func doneBtnClik(sender: AnyObject) {
        // 1. Set the Unit type
        let hkUnit = HKUnit.meterUnitWithMetricPrefix(.Kilo)
        
        // 2. Save the workout
        HealthKitUtil.saveRunWorkout(startDate!, endDate:endDate!, distance: distance , distanceUnit:hkUnit, kiloCalories:energyBurned!, completion: { (success, error ) -> Void in
            if( success ) {
                print("Workout saved!")
            } else if( error != nil ) {
                print("\(error)")
            }
        })
        self.navigationController?.popViewControllerAnimated(true)
    }
    
  
  
}

