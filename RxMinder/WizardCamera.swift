//
//  WizardStart.swift
//  RxMinder
//
//  Created by Noah Rubin on 9/7/19.
//  Copyright © 2019 Noah Rubin. All rights reserved.
//

import SwiftUI

struct WizardCamera: View {
    var body: some View {
        //NavigationView {
            VStack {
                HStack {
                    Image(systemName: "camera.circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Image(systemName: "pano")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                Text("Open the camera app and take a panorama picture of the pill bottle, then come back here when you're done.")
                    .multilineTextAlignment(.center)
                    .padding()
                NavigationLink(destination: WizardGetPhoto()) {
                    Button("Continue") { }
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                NavigationLink(destination: WizardEdit(medication: Medication.default)) {
                    Button("Enter manually") { }
//                        .foregroundColor(.white)
//                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Camera")
            .padding()
        //}
    }
}

struct WizardCamera_Previews: PreviewProvider {
    static var previews: some View {
        WizardCamera()
    }
}
