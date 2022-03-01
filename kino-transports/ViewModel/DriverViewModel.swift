//
//  DriverViewModel.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 01/03/2022.
//

import SwiftUI
import CoreLocation
import Firebase

class DriverViewModel: ObservableObject {
    @Published var loading = false
    @Published var hasRequest = false
    
    let isAvailible = true
    
    let ref = Firestore.firestore()
    let uid = Auth.auth().currentUser!.uid
    
    init() {
        ref.collection("Corridas").whereField("active", isEqualTo: true).addSnapshotListener {(snap, err) in
            if err != nil {
                self.hasRequest = false
                print((err?.localizedDescription)!)
                return
            }
            
            if self.isAvailible {
                let requests = snap?.documents
                if requests!.count > 0 {
                    //print("Tem: \(requests)")
                    self.hasRequest = true
                }
                else{
                    self.hasRequest = false
                }
            }
        }
    }
}
