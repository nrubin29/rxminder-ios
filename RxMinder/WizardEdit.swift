//
//  WizardStart.swift
//  RxMinder
//
//  Created by Noah Rubin on 9/7/19.
//  Copyright © 2019 Noah Rubin. All rights reserved.
//

import SwiftUI

struct WizardEdit: View {
    @State var medication: Medication
    @State var isFinished = false
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Medication")
                    TextField("", text: $medication.medication_name)
                }
                HStack {
                    Text("Pills per dose")
                    TextField("", text: $medication.pills_per_dose)
                }
                HStack {
                    Text("Doses per day")
                    TextField("", text: $medication.doses_per_day)
                }
                HStack {
                    Text("Total quantity")
                    TextField("", text: $medication.total_qty)
                }
                HStack {
                    Text("Num mg")
                    TextField("", text: $medication.num_mg)
                }
            }
            NavigationLink(destination: WizardCamera()) {
                Button("Continue") {
                    self.sendMedication()
                }
            }
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            NavigationLink(destination: WizardEnd(), isActive: $isFinished) { Text("") }
        }
        .navigationBarTitle("Edit Medication")
        .padding()
    }
    
    func sendMedication() {
        var urlRequest = URLRequest(url: URL(string: "http://10.251.95.251:5000/update")!)
        urlRequest.httpMethod = "POST"

        URLSession.shared.uploadTask(with: urlRequest, from: try! JSONEncoder().encode(medication), completionHandler: { responseData, response, error in
                    print(responseData, response, error)
            print(String(data: responseData!, encoding: .utf8)!)
            Store.addMedication(self.medication)
            self.isFinished = true
        //            if error == nil {
        //                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
        //                if let json = jsonData as? [String: Any] {
        //                    print(json)
        //                }
        //            }
                }).resume()
    }
}

struct WizardEdit_Previews: PreviewProvider {
    static var previews: some View {
        WizardEdit(medication: Medication(medication_name: "Advil", pills_per_dose: "1", doses_per_day: "6", total_qty: "6", num_mg: "200mg"))
    }
}
