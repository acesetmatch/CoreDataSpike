//
//  DeviceInfoViewController.swift
//  TestCoreDataLayer
//
//  Created by Shawn on 9/23/16.
//  Copyright © 2016 Gene Backlin. All rights reserved.
//

import UIKit
import CoreDataLayer
class DeviceInfoViewController: UIViewController {

    @IBOutlet weak var batteryChargeLbl: UILabel!
    @IBOutlet weak var tipLife: UILabel!
    @IBOutlet weak var treatmentLife: UILabel!
    @IBOutlet weak var lifetimeUse: UILabel!
    @IBOutlet weak var firstUse: UILabel!
    @IBOutlet weak var lastSync: UILabel!
    
    var dateLastTipChange: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dateLastTipChange = Date()
        var deviceInfo: [String : AnyObject] = [String : AnyObject]()
        deviceInfo["timeBLEOn"] = 30.0 as AnyObject
        deviceInfo["timeCharging"] = 20.0 as AnyObject?
        deviceInfo["timeIdle"] = 100.0 as AnyObject?
        deviceInfo["timeOn"] = 50.0 as AnyObject?
        deviceInfo["dateLastTipChange"] =  dateLastTipChange as AnyObject?
        CoreDataLayer.sharedInstance.saveDeviceInfo(deviceInfo: deviceInfo)
    
        //get Device Info
        let deviceData = CoreDataLayer.sharedInstance.getDeviceInfo()
        self.batteryChargeLbl.text = "\(deviceData?.timeBLEOn)"
        self.tipLife.text = "\(deviceData?.timeCharging)"
        self.treatmentLife.text = "\(deviceData?.timeIdle)"
        self.lifetimeUse.text = "\(deviceData?.timeOn)"
        self.firstUse.text = "\(deviceData?.dateLastTipChange)"

        
        // Do deviceInfo additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
