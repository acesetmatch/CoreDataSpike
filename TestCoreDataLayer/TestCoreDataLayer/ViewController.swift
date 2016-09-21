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
        params["index"] = Int(0) as AnyObject
        params["dateTime"] = Date() as AnyObject
        params["level"] = Int(5) as AnyObject
        params["realLevel"] = Double(2.5) as AnyObject
        params["duration"] = Int(23) as AnyObject

        // Save a treatment
        
        CoreDataLayer.sharedInstance.savePatientTreatment(patientTreatment: params)
        
        // Get a specific treatment by index
        let patientTreatment: PatientTreatment? = CoreDataLayer.sharedInstance.getPatientTreatmentForIndedx(index: 0)
        print("patientTreatment: \(patientTreatment!)")

        // Update a treatment
        patientTreatment?.level = 4
        var result: Bool = CoreDataLayer.sharedInstance.updatePatientTreatment(patientTreatment: patientTreatment!)
        print("result: \(result)")
        
        // Fetch all treatments
        var results = CoreDataLayer.sharedInstance.getPatientTreatments()
        print("results: \(results!)")
        
        // Drop the database
        result = CoreDataLayer.sharedInstance.drop()
        print("result: \(result)")
        results = CoreDataLayer.sharedInstance.getPatientTreatments()
        print("results: \(results)")
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

