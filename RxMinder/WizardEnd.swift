//
//  WizardStart.swift
//  RxMinder
//
//  Created by Noah Rubin on 9/7/19.
//  Copyright © 2019 Noah Rubin. All rights reserved.
//

import SwiftUI

struct WizardEnd: View {
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle")
                .resizable()
                .frame(width: 100, height: 100)
            Text("Your medication has been added successfully. Swipe down to close the wizard.")
                .multilineTextAlignment(.center)
                .padding()
        }
        .navigationBarTitle("All done!")
        .padding()
    }
}

struct WizardEnd_Previews: PreviewProvider {
    static var previews: some View {
        WizardEnd()
    }
}
