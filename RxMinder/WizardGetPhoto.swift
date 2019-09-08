//
//  ContentView.swift
//  RxMinder
//
//  Created by Noah Rubin on 9/6/19.
//  Copyright © 2019 Noah Rubin. All rights reserved.
//

import SwiftUI
import Photos
import CoreData

struct WizardGetPhoto: View {
    @Environment(\.managedObjectContext) var managedObjectContext
//    @Environment(\.store) var store: Store
    
    @ObservedObject var latestPhoto = LatestPhoto()
    
    @State var medication = Medication.default
    @State var isFinished = false
    
    var body: some View {
        VStack {
            Text("Here's your latest image:")
            if latestPhoto.photo != nil {
                latestPhoto.photo!
            }
            Button("Continue") {
                self.uploadPicture()
            }
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .disabled(latestPhoto.image == nil)
            NavigationLink(destination: WizardEdit(medication: medication), isActive: $isFinished) { Text("") }
        }
        .navigationBarTitle("Label Photo")
        .padding()
    }
    
    private func uploadPicture() {
//        let desc = NSEntityDescription()
//        desc.name = "Medication"
//        desc.managedObjectClassName = "RxMinder.Medication"
//
//        let medication = Medication(entity: desc, insertInto: self.managedObjectContext)
//        self.medication = Medication(context: self.managedObjectContext)
//        self.medication.name = "Advil"
//        self.medication.timeToRefill = "Today"
//
//        print(self.managedObjectContext)
//        print(self._managedObjectContext)
//        print(self.managedObjectContext.insertedObjects.first!.changedValues())
//
//        do {
//            try self.managedObjectContext.save()
//        } catch {
//            print("*** WE GOT AN ERROR")
//            print(error)
//            print(error.localizedDescription)
//        }
        
//        self.medication = Medication(medicine_name: "Advil", pills_per_dose: "1", doses_per_day: "6", total_qty: "6", num_mg: "200")
//
//        self.isFinished = true
        
//        store.isShowingSetup = false
        
//        let url = URL(string: "https://sheltered-forest-46144.herokuapp.com/process_image")
        
        let url = URL(string: "http://10.251.95.251:5000/process_image")

        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString

        let session = URLSession.shared

        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"

        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"fileToUpload\"; filename=\"image.png\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(latestPhoto.image!.pngData()!)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            print(responseData, response, error)
            print(String(data: responseData!, encoding: .utf8)!)
            
            let decoder = JSONDecoder()
            
            do {
                self.medication = try decoder.decode(Medication.self, from: responseData!)
                
                self.isFinished = true
            }
            
            catch {
                print(error)
            }
            
//            print(response.)
//            if error == nil {
//                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
//                if let json = jsonData as? [String: Any] {
//                    print(json)
//                }
//            }
        }).resume()
        
//        var request = URLRequest(url: URL(string: "https://sheltered-forest-46144.herokuapp.com/process_image")!)
//        request.httpMethod = "post"
//
//        let task = URLSession.shared.uploadTask(with: request, from: latestPhoto.image!.pngData()) { data, urlResponse, err in
//            if let err = err {
//                print("Error!")
//                print(err.localizedDescription)
//            }
//
//            else if let data = data {
//                print(String(data: data, encoding: .utf8)!)
////                let decoder = JSONDecoder()
////
////                do {
////                    let obj = try decoder.decode(T.self, from: data)
////                    callback(obj)
////                }
////
////                catch {
////                    print(error)
////                    callback(nil)
////                }
//            }
//        }
//
//        task.resume()
    }
}

struct WizardGetPhoto_Previews: PreviewProvider {
    static var previews: some View {
        WizardGetPhoto()
    }
}
