//
//  DeviceInfo+CoreDataProperties.swift
//  CoreDataLayer
//
//  Created by Shawn on 9/23/16.
//  Copyright © 2016 Gene Backlin. All rights reserved.
//

import Foundation
import CoreData


extension DeviceInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeviceInfo> {
        return NSFetchRequest<DeviceInfo>(entityName: "DeviceInfo");
    }

    @NSManaged open var firstUse: NSDate?
    @NSManaged open var lastSync: NSDate?
    @NSManaged open var batteryCharge: Float
    @NSManaged open var tipLife: Float
    @NSManaged open var lifetimeUse: Float
    @NSManaged open var treatmentLife: Float

}
