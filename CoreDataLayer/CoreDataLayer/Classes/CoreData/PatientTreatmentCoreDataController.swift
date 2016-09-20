//
//  PatientTreatmentCoreDataController.swift
//  CoreDataLayer
//
//  Created by Gene Backlin on 9/20/16.
//  Copyright © 2016 Gene Backlin. All rights reserved.
//

import UIKit
import CoreData

//open fileprivate(set) var dateTime: Date?
//open fileprivate(set) var level: Int?
//open fileprivate(set) var realLevel: Double?
//open fileprivate(set) var duration: Int?


class PatientTreatmentCoreDataController: CoreDataController {
    open static let sharedInstance = PatientTreatmentCoreDataController()
    
    override init() {
        super.init()
        self.dataModel = "TearBudHistory"
        self.bundleName = "CoreDataLayer"
        self.bundleIdentifier = "com.marizack.\(self.bundleName!)"
    }
    
    func savePatientTreatment(patientTreatment: [String : AnyObject]) {
        let dateTime: Date = patientTreatment["dateTime"] as! Date
        let level: Int = patientTreatment["level"] as! Int
        let realLevel: Double = patientTreatment["realLevel"] as! Double
        let duration: Int = patientTreatment["duration"] as! Int
        
        print("level: \(level)")
        
        let treatmentData: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: "PatientTreatment", into: self.managedObjectContext) as! NSManagedObject
        treatmentData.setValue(dateTime, forKey: "dateTime")
        treatmentData.setValue(level, forKey: "level")
        treatmentData.setValue(realLevel, forKey: "realLevel")
        treatmentData.setValue(duration, forKey: "duration")
        
        self.saveContext()
    }

    func getPatientTreatments() -> [String : PatientTreatment]? {
        let context: NSManagedObjectContext = self.managedObjectContext
        var request: NSFetchRequest<PatientTreatment>? = PatientTreatment.fetchRequest()
        
        request?.returnsObjectsAsFaults = false
//        if predicateValue != nil {
//            request.predicate = NSPredicate(format: predicateFormat!, predicateValue!)
//        }
        request?.fetchBatchSize = 20

        var results: [PatientTreatment]?
        var patientTreatments: [String : PatientTreatment]?
        
        do {
            try results = context.execute(request!) as? [PatientTreatment]
            
            if (results?.count)! > 0 {
                patientTreatments = [String : PatientTreatment]()
                
                for treatment: PatientTreatment in results! {
                    let key: String = String(describing: treatment.dateTime?.description)
                    patientTreatments![key] = (treatment as! AnyObject) as! PatientTreatment
                }
            }
        } catch _ {
            patientTreatments = nil
        }

        return patientTreatments!
    }
    
}
