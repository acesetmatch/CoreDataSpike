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

    @NSManaged public var firstUse: NSDate?
    @NSManaged public var lastSync: NSDate?
    @NSManaged public var batteryCharge: Float
    @NSManaged public var tipLife: Float
    @NSManaged public var lifetimeUse: Float
    @NSManaged public var treatmentLife: Float

}
