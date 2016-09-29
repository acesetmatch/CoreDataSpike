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
    
    var _fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?

    override init() {
        super.init()
        self.dataModel = "TearBudHistory"
        self.entityName = "PatientTreatment"
        self.bundleName = "CoreDataLayer"
        self.bundleIdentifier = "com.marizack.\(self.bundleName!)"
    }
    
    // MARK: - Save
    
    func savePatientTreatment(patientTreatment: [String : AnyObject]) {
        var index: Int? = patientTreatment["index"] as? Int
        if index == nil {
            index = self.count()
        }
        
        let treatmentData: PatientTreatment? = self.getPatientTreatmentForIndex(index: index!)
        
        if treatmentData == nil {
            let dateTime: Date = patientTreatment["dateTime"] as! Date
            let level: Int = patientTreatment["level"] as! Int
            let realLevel: Double = patientTreatment["realLevel"] as! Double
            let duration: Int = patientTreatment["duration"] as! Int
            
            let context = self.managedObjectContext
            
            let treatmentData: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: self.entityName!, into: context) as! NSManagedObject
            treatmentData.setValue(index, forKey: "index")
            treatmentData.setValue(dateTime, forKey: "dateTime")
            treatmentData.setValue(level, forKey: "level")
            treatmentData.setValue(realLevel, forKey: "realLevel")
            treatmentData.setValue(duration, forKey: "duration")
            
            self.saveContext()
        } else {
            print("record exists for index: \(index)")
        }
    }

    func savePatientTreatmentWithModel(patientTreatment: PatientTreatment) {
        var index = patientTreatment.index
        if index == nil {
            index = Int32(self.count())
        }

        if index < 1 {
            let context = self.managedObjectContext
            
            let treatmentData: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: self.entityName!, into: context) as! NSManagedObject
            treatmentData.setValue(patientTreatment.index, forKey: "index")
            treatmentData.setValue(patientTreatment.dateTime, forKey: "dateTime")
            treatmentData.setValue(patientTreatment.level, forKey: "level")
            treatmentData.setValue(patientTreatment.realLevel, forKey: "realLevel")
            treatmentData.setValue(patientTreatment.duration, forKey: "duration")
            
            self.saveContext()
        } else {
            print("record exists for index: \(index)")
        }
    }

    func count() -> Int {
        let context: NSManagedObjectContext = self.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = self.fetchRequestForEntityName(entityName: self.entityName, predicateFormat: nil, predicateValue: nil)
        var count: Int?
        
        do {
            try count = context.count(for: request)
        } catch _ {
            count = 0
        }

        return count!
    }
    
    // MARK: - Get
    
    func getPatientTreatments() -> [String : PatientTreatment]? {
        let context: NSManagedObjectContext = self.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = self.fetchRequestForEntityName(entityName: self.entityName, predicateFormat: nil, predicateValue: nil)
        
        var results: [NSManagedObject]?
        var patientTreatments: [String : PatientTreatment]?
        
        do {
            try results = context.fetch(request) as! [NSManagedObject]
            
            if (results?.count)! > 0 {
                patientTreatments = [String : PatientTreatment]()
                
                for treatment: NSManagedObject in results! {
                    let patientTreatment: PatientTreatment = treatment as! PatientTreatment
                    let key: String = String(describing: patientTreatment.index.description)
                    
                    patientTreatments![key] = (treatment as! AnyObject) as! PatientTreatment
                }
            }
        } catch _ {
            patientTreatments = nil
        }
        
        return patientTreatments
    }
    
    func getPatientTreatmentForIndex(index: Int) -> PatientTreatment? {
        return self.getPatientTreatmentForIndex(index: index, format: "index = %d")
    }
    
    func getPatientTreatmentsForIndex(index: Int, format: String) -> [String : PatientTreatment]? {
        let context: NSManagedObjectContext = self.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = self.fetchRequestForEntityName(entityName: self.entityName, predicateFormat: format, predicateValue: index)
//        let sortDescriptor = NSSortDescriptor(key: "dateTime", ascending: false)
//        request.sortDescriptors = [sortDescriptor]
        
        var results: [NSManagedObject]?
        var patientTreatments: [String : PatientTreatment]?
        
        do {
            try results = context.fetch(request) as! [NSManagedObject]
            
            if (results?.count)! > 0 {
                patientTreatments = [String : PatientTreatment]()
                
                for treatment: NSManagedObject in results! {
                    let patientTreatment: PatientTreatment = treatment as! PatientTreatment
                    let key: String = String(describing: patientTreatment.index.description)
                    
                    patientTreatments![key] = (treatment as! AnyObject) as! PatientTreatment
                }
            }
        } catch _ {
            patientTreatments = nil
        }
        
        let keys: [String] = Array(patientTreatments!.keys)
        
        return patientTreatments
    }
    
    func getPatientTreatmentsForDateRange(startDate: Date, endDate: Date) -> [PatientTreatment]? {
        let context: NSManagedObjectContext = self.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: self.entityName!)
        //        self.fetchRequestForEntityName(entityName: self.entityName, predicateFormat: "startDate <= %@ AND endDate >= %@", predicateValue: startDate)
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "(dateTime >= %@) AND (dateTime <= %@)", startDate as CVarArg, endDate as CVarArg)
        var results: [NSManagedObject]?
        var patientTreatments: [PatientTreatment] = [PatientTreatment]()
        
        do {
            try results = context.fetch(request) as! [NSManagedObject]
            
            if (results?.count)! > 0 {
//                patientTreatments = [String : PatientTreatment]()
                
                for treatment: NSManagedObject in results! {
                    let patientTreatment: PatientTreatment = treatment as! PatientTreatment
                    patientTreatments.append(patientTreatment)
//                    let key: String = String(describing: patientTreatment.index.description)
                    
//                    patientTreatments![key] = (treatment as! AnyObject) as! PatientTreatment
                }
            }
        } catch _ {
            print("patient treatments is nil")
        }
        
        return patientTreatments
    }
    
//    func parseTreatments(_ treatmentHistory: [String : PatientTreatment]?) -> [String : PatientTreatment]? {
//        var tempTreatmentHistory: [String : PatientTreatment]?
//        
//        if treatmentHistory != nil {
//            tempTreatmentHistory = [String : PatientTreatment]()
//            
//            let keys: [String] = Array(treatmentHistory!.keys)
//            let sortedKeys = keys.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedDescending }
//            var treatmentDict: [String : PatientTreatmentData] = [String : PatientTreatmentData]()
//            // For each key (year)
//            for key in sortedKeys {
//                // get the treatment array
//                if let data: [PatientTreatment] = treatmentHistory![key] {
//                    // get the treatment time and use it as a key to a temporaty dictionary (MMMddhhmm)
//                    tempTreatmentHistory![key] = (data.reversed())
//                }
//                // refresh for the next key (year)
//                treatmentDict.removeAll()
//            }
//        }
//        
//        return tempTreatmentHistory
//    }
    
    func getPatientTreatmentForIndex(index: Int, format: String) -> PatientTreatment? {
        let context: NSManagedObjectContext = self.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = self.fetchRequestForEntityName(entityName: self.entityName, predicateFormat: format, predicateValue: self.count() - index - 1)
        
        var results: [NSManagedObject]?
        var patientTreatment: PatientTreatment?
        
        do {
            try results = context.fetch(request) as! [NSManagedObject]
            
            if (results?.count)! > 0 {
                for treatment: NSManagedObject in results! {
                    patientTreatment = treatment as! PatientTreatment
                    break
                }
            }
        } catch _ {
            patientTreatment = nil
        }
        
        return patientTreatment
    }
    
    // MARK: - Update
    
    func updatePatientTreatment(patientTreatment: PatientTreatment) -> Bool {
        var success: Bool = true

        let index: Int = Int(patientTreatment.index)
        let format: String = "index = %d"
        let context: NSManagedObjectContext = self.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = self.fetchRequestForEntityName(entityName: self.entityName, predicateFormat: format, predicateValue: index)
        
        var results: [NSManagedObject]?
        
        do {
            try results = context.fetch(request) as! [NSManagedObject]
            
            if (results?.count)! > 0 {
                for treatment: NSManagedObject in results! {
                    let localPatientTreatment: PatientTreatment = treatment as! PatientTreatment
                    localPatientTreatment.index = patientTreatment.index
                    localPatientTreatment.dateTime = patientTreatment.dateTime
                    localPatientTreatment.level = patientTreatment.level
                    localPatientTreatment.realLevel = patientTreatment.realLevel
                    localPatientTreatment.duration = patientTreatment.duration
                }
                
                self.saveContext()
            }
        } catch let error as Error {
            print("updatePatientTreatment - error: \(error)")
            success = false
        }
        
        return success
    }
    
    // MARK: - Delete
    
    func deletePatientTreatmentForKey(index: Int) -> Bool {
        return self.deletePatientTreatmentForKey(index: index, format: "index = %d")
    }
    
    func deletePatientTreatmentForKey(index: Int, format: String) -> Bool {
        var success: Bool = true
        
        let context: NSManagedObjectContext = self.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = self.fetchRequestForEntityName(entityName: self.entityName, predicateFormat: format, predicateValue: index)
        
        var results: [NSManagedObject]?
        
        do {
            try results = context.fetch(request) as! [NSManagedObject]
            
            if (results?.count)! > 0 {
                for treatment: NSManagedObject in results! {
                    context.delete(treatment)
                }
                
                self.saveContext()
            }
        } catch let error as Error {
            print("deletePatientTreatmentForKey - error: \(error)")
            success = false
        }
        
        return success
    }
    
    // MARK: - Drop
    
    func drop() -> Bool {
        var success: Bool = true
        
        let context: NSManagedObjectContext = self.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = self.fetchRequestForEntityName(entityName: self.entityName, predicateFormat: nil, predicateValue: nil)
        let dropRequest = NSBatchDeleteRequest(fetchRequest: request)

        do {
            try context.execute(dropRequest)
            self.saveContext()
        } catch {
            print("drop - error: \(error)")
            success = false
        }
        
        return success
    }
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entity(forEntityName: self.entityName!, in: self.managedObjectContext)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "index", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: "Master")
        //aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
        
        return _fetchedResultsController!
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            //self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
            break
        case .delete:
            //self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
            break
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            //tableView.insertRows(at: [newIndexPath!], with: .fade)
            break
        case .delete:
            //tableView.deleteRows(at: [indexPath!], with: .fade)
            break
        case .update:
            //self.configureCell(tableView.cellForRow(at: indexPath!)!, withObject: anObject as! NSManagedObject)
            break
        case .move:
            //tableView.moveRow(at: indexPath!, to: newIndexPath!)
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //self.tableView.endUpdates()
    }
    
    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
     // In the simplest, most efficient, case, reload the table view.
     self.tableView.reloadData()
     }
     */

}
