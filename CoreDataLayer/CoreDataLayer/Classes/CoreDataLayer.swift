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
    
    open func getPatientTreatmentForIndex(index: Int) -> PatientTreatment? {
        return PatientTreatmentCoreDataController.sharedInstance.getPatientTreatmentForIndex(index: index)
    }
    
    open func updatePatientTreatment(patientTreatment: PatientTreatment) -> Bool {
        return PatientTreatmentCoreDataController.sharedInstance.updatePatientTreatment(patientTreatment: patientTreatment)
    }

    open func drop() -> Bool {
        return PatientTreatmentCoreDataController.sharedInstance.drop()
    }
    
    open func count() -> Int {
        return PatientTreatmentCoreDataController.sharedInstance.count()
    }
    
    open func saveDeviceInfo(deviceInfo: [String: AnyObject]) {
        return DeviceInfoCoreDataViewController.sharedInstance.saveDeviceInfo(deviceInfo: deviceInfo)
    }
    
    open func updateDeviceInfo(deviceInfo: DeviceInfo) -> Bool {
        return DeviceInfoCoreDataViewController.sharedInstance.updateDeviceInfo(deviceInfo: deviceInfo)
    }
    
    open func getDeviceInfo() -> DeviceInfo? {
        return DeviceInfoCoreDataViewController.sharedInstance.getDeviceInfo()!
    }
    
    
    
}
