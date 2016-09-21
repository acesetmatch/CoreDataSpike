//
//  CoreDataController.swift
//  CoreDataLayer
//
//  Created by Gene Backlin on 9/20/16.
//  Copyright © 2016 Gene Backlin. All rights reserved.
//

import UIKit
import CoreData

class CoreDataController: NSObject {
    
    var dataModel: String?
    var bundleIdentifier: String?
    var bundleName: String?
    var entityName: String?
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.

        let bundleName = self.bundleName!
        let bundle: Bundle? = self.bundleForResource(bundleName: bundleName)
        var modelURL: URL?
        
        if bundle != nil {
            modelURL = bundle?.url(forResource: self.dataModel!, withExtension: "momd") as URL?
        } else {
            modelURL = self.modelPathForModel(dataModel: self.dataModel!)
        }
        
        return NSManagedObjectModel(contentsOf: modelURL! as URL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store

        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let url = self.applicationDocumentsDirectory.appendingPathComponent("\(self.dataModel).sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.

        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                //abort()
            }
        }
    }

    // MARK: - Utility methods
    
    func fetchRequestForEntityName(entityName: String?, predicateFormat: String?, predicateValue: Int?) -> NSFetchRequest<NSFetchRequestResult> {
        
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName!)
        
        request.returnsObjectsAsFaults = false
        if predicateValue != nil {
            request.predicate = NSPredicate(format: predicateFormat!, predicateValue!)
        }
        request.fetchBatchSize = 20
        
        return request
    }
    
    func bundleForResource(bundleName: String) -> Bundle? {
        var bundle: Bundle?
        let mainBundle: Bundle? = Bundle.main
        let url: NSURL? = mainBundle?.url(forResource: bundleName, withExtension: "bundle") as NSURL?
        
        if url != nil {
            bundle = Bundle(url: url! as URL)
        }
        
        return bundle
    }
    
    func modelPathForModel(dataModel: String?) -> URL? {
        var modelURL: URL?
        
        for bundle: Bundle in Bundle.allBundles {
            modelURL = bundle.url(forResource: dataModel!, withExtension: "momd")
        }
        
        if modelURL == nil {
            let bundleFromIdentifier: Bundle? = Bundle(identifier: self.bundleIdentifier!)
            modelURL = bundleFromIdentifier?.url(forResource: dataModel!, withExtension: "momd")
        }

        return modelURL
    }

}
