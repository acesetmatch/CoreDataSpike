//
//  CoreDataLayer.swift
//  CoreDataLayer
//
//  Created by Gene Backlin on 9/20/16.
//  Copyright © 2016 Gene Backlin. All rights reserved.
//

import UIKit
import CoreData

open class CoreDataLayer: NSObject {
    open static let sharedInstance = CoreDataLayer()

    open func savePatientTreatment(patientTreatment: [String : AnyObject]) {
        PatientTreatmentCoreDataController.sharedInstance.savePatientTreatment(patientTreatment: patientTreatment)
    }
    
    open func getPatientTreatments() -> [String : PatientTreatment]? {
        return PatientTreatmentCoreDataController.sharedInstance.getPatientTreatments()
    }
    
    open func getPatientTreatmentForIndedx(index: Int) -> PatientTreatment? {
        return PatientTreatmentCoreDataController.sharedInstance.getPatientTreatmentForIndex(index: index)
    }
    
    open func updatePatientTreatment(patientTreatment: PatientTreatment) -> Bool {
        return PatientTreatmentCoreDataController.sharedInstance.updatePatientTreatment(patientTreatment: patientTreatment)
    }

    open func drop() -> Bool {
        return PatientTreatmentCoreDataController.sharedInstance.drop()
    }
}
