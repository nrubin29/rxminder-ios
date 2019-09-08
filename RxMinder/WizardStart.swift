//
//  WizardStart.swift
//  RxMinder
//
//  Created by Noah Rubin on 9/7/19.
//  Copyright © 2019 Noah Rubin. All rights reserved.
//

import SwiftUI

struct WizardStart: View {
//    @EnvironmentObject var store: Store
    
    init() {
//        print(store)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("This wizard will help you add a new medication to RxMinder. It's as easy as taking a few pictures of the label on your pill bottle!")
                    .multilineTextAlignment(.center)
                    .padding()
                NavigationLink(destination: WizardCamera()) {
                    Button("Continue") { }
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            }
            .navigationBarTitle("Add Medication")
            .padding()
        }
    }
}

struct WizardStart_Previews: PreviewProvider {
    static var previews: some View {
        WizardStart()
    }
}
