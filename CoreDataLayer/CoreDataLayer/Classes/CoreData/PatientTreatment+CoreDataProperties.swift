//
//  PatientTreatment+CoreDataProperties.swift
//  
//
//  Created by Gene Backlin on 9/20/16.
//
//

import Foundation
import CoreData


extension PatientTreatment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PatientTreatment> {
        return NSFetchRequest<PatientTreatment>(entityName: "PatientTreatment");
    }

    @NSManaged public var dateTime: NSDate?
    @NSManaged public var duration: Int32
    @NSManaged public var level: Int32
    @NSManaged public var realLevel: Double

}
