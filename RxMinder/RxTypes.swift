//
//  RxTypes.swift
//  RxMinder
//
//  Created by Noah Rubin on 9/7/19.
//  Copyright © 2019 Noah Rubin. All rights reserved.
//

import Foundation
import CoreData

//class Medication: NSManagedObject, Identifiable {
//    public var id: String {
//        get {
//            return self.name!
//        }
//    }
//
//    @NSManaged public var name: String?
//    @NSManaged public var timeToRefill: String?
//}

//extension Medication: Identifiable {
//    public var id: String {
//        get {
//            return self.name!
//        }
//    }
//}
//
//extension Medication {
//    static func allMedicationsFetchRequest() -> NSFetchRequest<Medication> {
//
//        let request = NSFetchRequest<Medication>(entityName: "Medication")
//        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
//        return request
//    }
//}

struct MedicationResponse : Codable {
    var fields: Medication
}

struct Medication : Identifiable, Codable {
    static var `default`: Medication {
        get {
            return Medication(medication_name: "", pills_per_dose: "", doses_per_day: "", total_qty: "", num_mg: "")
        }
    }
    
    var id: String {
        get {
            return medication_name
        }
    }

    var medication_name: String
    var pills_per_dose: String
    var doses_per_day: String
    var total_qty: String
    var num_mg: String
}
