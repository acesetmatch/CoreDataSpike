//
//  ViewController.swift
//  TestCoreDataLayer
//
//  Created by Gene Backlin on 9/20/16.
//  Copyright © 2016 Gene Backlin. All rights reserved.
//

import UIKit
import CoreDataLayer

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var params: [String : AnyObject] = [String : AnyObject]()
        params["dateTime"] = Date() as AnyObject
        params["level"] = Int(5) as AnyObject
        params["realLevel"] = Double(2.5) as AnyObject
        params["duration"] = Int(23) as AnyObject

        CoreDataLayer.sharedInstance.savePatientTreatment(patientTreatment: params)
        let results: [String : PatientTreatment]? = CoreDataLayer.sharedInstance.getPatientTreatments()
        
        print("results: \(results)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

