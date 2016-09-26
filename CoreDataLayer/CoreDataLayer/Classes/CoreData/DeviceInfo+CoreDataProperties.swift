//
//  DeviceInfo+CoreDataProperties.swift
//  CoreDataLayer
//
//  Created by Shawn on 9/26/16.
//  Copyright © 2016 Gene Backlin. All rights reserved.
//

import Foundation
import CoreData


extension DeviceInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeviceInfo> {
        return NSFetchRequest<DeviceInfo>(entityName: "DeviceInfo");
    }

    @NSManaged public var timeCharging: Double
    @NSManaged public var dateLastTipChange: NSDate?
    @NSManaged public var timeOn: Double
    @NSManaged public var timeBLEOn: Double
    @NSManaged public var timeIdle: Double

}
