//
//  PatientTreatment+CoreDataProperties.swift
//  
//
//  Created by Gene Backlin on 9/21/16.
//
//

import Foundation
import CoreData


extension PatientTreatment {

    @nonobjc open class func fetchRequest() -> NSFetchRequest<PatientTreatment> {
        return NSFetchRequest<PatientTreatment>(entityName: "PatientTreatment");
    }

    @NSManaged open var dateTime: NSDate?
    @NSManaged open var duration: Int32
    @NSManaged open var level: Int32
    @NSManaged open var realLevel: Double
    @NSManaged open var index: Int32

}
