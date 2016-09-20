//
//  CoreDataLayer.swift
//  CoreDataLayer
//
//  Created by Gene Backlin on 9/20/16.
//  Copyright © 2016 Gene Backlin. All rights reserved.
//

import UIKit
import CoreData

public class CoreDataLayer: NSObject {
    public static let sharedInstance = CoreDataLayer()

    public func savePatientTreatment(patientTreatment: [String : AnyObject]) {
        PatientTreatmentCoreDataController.sharedInstance.savePatientTreatment(patientTreatment: patientTreatment)
    }
    
    public func getPatientTreatments() -> [String : PatientTreatment]? {
        return PatientTreatmentCoreDataController.sharedInstance.getPatientTreatments()
    }
}
