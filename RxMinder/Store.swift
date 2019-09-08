//
//  Store.swift
//  RxMinder
//
//  Created by Noah Rubin on 9/7/19.
//  Copyright © 2019 Noah Rubin. All rights reserved.
//

import SwiftUI
import Combine

class Store : ObservableObject {
    @Published var isShowingSetup = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    static var medications = CurrentValueSubject<[Medication], Never>([])
    
    static func fetchMedications() {
        var urlRequest = URLRequest(url: URL(string: "http://10.251.95.251:5000/list_all")!)
//        urlRequest.httpMethod = "GET"

        URLSession.shared.dataTask(with: urlRequest, completionHandler: { responseData, response, error in
                    print(responseData, response, error)
            print(String(data: responseData!, encoding: .utf8)!)
            medications.send(try! JSONDecoder().decode([MedicationResponse].self, from: responseData!).map {$0.fields})
        //            if error == nil {
        //                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
        //                if let json = jsonData as? [String: Any] {
        //                    print(json)
        //                }
        //            }
                }).resume()
        
        
//        medications.send([Medication(medication_name: "Advil", pills_per_dose: "1", doses_per_day: "6", total_qty: "6", num_mg: "200mg")])
//        print("Sent")
    }
    
    // TODO: Remove this once fetchMedications works.
    static func addMedication(_ medication: Medication) {
        medications.send(medications.value + [medication])
    }
    
    static func deleteMedication(_ medication: Medication) {
        var urlRequest = URLRequest(url: URL(string: "http://10.251.95.251:5000/delete?medication_name=\(medication.medication_name)")!)
        //        urlRequest.httpMethod = "GET"

                URLSession.shared.dataTask(with: urlRequest, completionHandler: { responseData, response, error in
                            print(responseData, response, error)
                    print(String(data: responseData!, encoding: .utf8)!)
                    Store.fetchMedications()
                //            if error == nil {
                //                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                //                if let json = jsonData as? [String: Any] {
                //                    print(json)
                //                }
                //            }
                        }).resume()
    }
}

//struct StoreEnvironmentKey: EnvironmentKey {
//    static var defaultValue: Store? = nil
//}
//
//extension EnvironmentValues {
//  var store: Store {
//    get { self[StoreEnvironmentKey.self]! }
//    set { }
//  }
//}
