//
//  DeviceInfoCoreDataViewController.swift
//  CoreDataLayer
//
//  Created by Shawn on 9/23/16.
//  Copyright © 2016 Gene Backlin. All rights reserved.
//

import UIKit
import CoreData

class DeviceInfoCoreDataViewController: CoreDataController {

    open static let sharedInstance = DeviceInfoCoreDataViewController()
    
    var _fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    override init() {
        super.init()
        self.dataModel = "TearBudHistory"
        self.entityName = "DeviceInfo"
        self.bundleName = "CoreDataLayer"
        self.bundleIdentifier = "com.marizack.\(self.bundleName!)"
    }
    
    // MARK: - Save
    
    func saveDeviceInfo(deviceInfo: [String : AnyObject]) {
        let deviceData: [String : AnyObject]? = deviceInfo
        if deviceData != nil {
            let batteryCharge: CGFloat = deviceInfo["batteryCharge"] as! CGFloat
            let lifetimeUse: CGFloat = deviceInfo["lifetimeUse"] as! CGFloat
            let tipLife: CGFloat = deviceInfo["tipLife"] as! CGFloat
            let treatmentLife: CGFloat = deviceInfo["treatmentLife"] as! CGFloat
            let firstUse: Date = deviceInfo["firstUse"] as! Date
            let lastSync: Date = deviceInfo["lastSync"] as! Date
            
            let context = self.managedObjectContext
            
            let deviceData: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: self.entityName!, into: context) as! NSManagedObject
            deviceData.setValue(batteryCharge, forKey: "batteryCharge")
            deviceData.setValue(lifetimeUse, forKey: "lifetimeUse")
            deviceData.setValue(tipLife, forKey: "tipLife")
            deviceData.setValue(treatmentLife, forKey: "treatmentLife")
            deviceData.setValue(firstUse, forKey: "firstUse")
            deviceData.setValue(lastSync, forKey: "lastSync")
            
            self.saveContext()
        } else {
            print("record exists for index: \(index)")
        }
    }
    
    func saveDeviceInfoWithModel(deviceInfo: [String : AnyObject]) {
        if deviceInfo != nil {
            let context = self.managedObjectContext

            let deviceData: DeviceInfo = NSEntityDescription.insertNewObject(forEntityName: self.entityName!, into: context) as! DeviceInfo
            deviceData.setValue(deviceData.batteryCharge, forKey: "batteryCharge")
            deviceData.setValue(deviceData.lifetimeUse, forKey: "lifetimeUse")
            deviceData.setValue(deviceData.tipLife, forKey: "tipLife")
            deviceData.setValue(deviceData.treatmentLife, forKey: "treatmentLife")
            deviceData.setValue(deviceData.firstUse, forKey: "firstUse")
            deviceData.setValue(deviceData.lastSync, forKey: "lastSync")
            self.saveContext()
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
    
    func getDeviceInfo() -> DeviceInfo? {
        let context: NSManagedObjectContext = self.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = self.fetchRequestForEntityName(entityName: self.entityName, predicateFormat: nil, predicateValue: nil)
        var results: [NSManagedObject]?
        var deviceInfo: DeviceInfo?
        
        do {
            try results = context.fetch(request) as! [NSManagedObject]
            if results != nil {
                for deviceInfoResult: NSManagedObject in results! {
                    let d: DeviceInfo = deviceInfoResult as! DeviceInfo
                    deviceInfo = deviceInfoResult as! DeviceInfo
                    break
                }
            }
        } catch _ {
            deviceInfo = nil
        }
        
        return deviceInfo
    }
    
 

    // MARK: - Update
    
    func updateDeviceInfo(deviceInfo: DeviceInfo) -> Bool {
        var success: Bool = true
//        let format: String = "index = %d"
        let context: NSManagedObjectContext = self.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = self.fetchRequestForEntityName(entityName: self.entityName, predicateFormat: nil, predicateValue: nil)
        
        var results: [NSManagedObject]?
        
        do {
            try results = context.fetch(request) as! [NSManagedObject]
            
            if (results?.count)! > 0 {
                let localDeviceInfo: DeviceInfo = deviceInfo as! DeviceInfo
                localDeviceInfo.batteryCharge = deviceInfo.batteryCharge
                localDeviceInfo.lifetimeUse = deviceInfo.lifetimeUse
                localDeviceInfo.tipLife = deviceInfo.tipLife
                localDeviceInfo.treatmentLife = deviceInfo.treatmentLife
                localDeviceInfo.firstUse = deviceInfo.firstUse
                localDeviceInfo.lastSync = deviceInfo.lastSync
                self.saveContext()
            }
        } catch let error as Error {
            print("updateDeviceInfo - error: \(error)")
            success = false
        }
        
        return success
    }
    
    // MARK: - Delete
    
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
