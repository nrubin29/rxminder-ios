//
//  MedicationsList.swift
//  RxMinder
//
//  Created by Noah Rubin on 9/7/19.
//  Copyright © 2019 Noah Rubin. All rights reserved.
//

import SwiftUI
import Combine

struct MedicationsList: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
//    @FetchRequest(fetchRequest: Medication.allMedicationsFetchRequest()) var medications: FetchedResults<Medication>
    
//    @State var medications: [Medication] = []
    
    @EnvironmentObject var store: Store
    
//    @State var testxyz = CurrentValueSubject<[Medication], Never>([])
    
    init() {
//        Store.medications.receive(subscriber: Subscribers.Sink(receiveCompletion: {_ in }) {medications in self.medications = medications
//        })
        
//        Store.medications.sink { medications in self.medications = medications }
        
//        print(self.store)
        Store.fetchMedications()
    }
    
    var body: some View {
        NavigationView {
            List(Store.medications.value) { (medication: Medication) in
                HStack {
                    VStack {
                        HStack {
                            Text(medication.medication_name)
                            Spacer()
                            Text(medication.num_mg)
                        }
                        HStack {
                            Text("\(medication.pills_per_dose) pill(s)/dose, \(medication.doses_per_day) dose(s)/day")
                            Spacer()
                            Text("\(medication.total_qty) total pills")
                        }
                    }
                }
                Button(action: {
                    Store.deleteMedication(medication)
                }) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.red)
                }
            }
            .navigationBarTitle("RxMinder")
            .navigationBarItems(trailing: Button(action: {
                self.store.isShowingSetup = true
            }, label: { Image(systemName: "plus").imageScale(.large) }))
        }
        .sheet(isPresented: $store.isShowingSetup) {
            WizardStart().environmentObject(self.store) }
    }
}

struct MedicationsList_Previews: PreviewProvider {
    static var previews: some View {
        MedicationsList()
            .environmentObject(Store())
    }
}
