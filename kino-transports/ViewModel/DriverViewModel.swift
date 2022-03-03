//
//  DriverViewModel.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 01/03/2022.
//

import SwiftUI
import CoreLocation
import MapKit
import Firebase

class DriverViewModel: ObservableObject {
    @Published var request = RequestModel()
    
    @Published var loading = false
    @Published var hasRequest = false
    
    var isAvailible = true
    
    let ref = Firestore.firestore()
    let uid = Auth.auth().currentUser!.uid
    var requestID = ""
    
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
                    //self.isAvailible = false
                    //print("Tem: \(requests)")
                    self.hasRequest = true
                    let data = requests![0].data()
                    self.requestID = requests![0].documentID
                    
                    self.request = RequestModel(
                        active: data["active"] as? Bool,
                        cliente: data["cliente"] as? String,
                        from: data["from"] as? GeoPoint,
                        motorista: data["motorista"] as? String,
                        preco: data["preco"] as? String,
                        tipoCarro: data["tipoCarro"] as? String,
                        to: data["to"] as? GeoPoint,
                        fromTitle: data["fromTitle"] as? String,
                        toTitle: data["toTitle"] as? String
                    )
                }
                else{
                    self.isAvailible = true
                    self.hasRequest = false
                }
            }
        }
    }
    
    func acceptRequest(){
        self.ref.collection("Corridas").document(requestID).setData([
            "motorista": uid,
        ], merge: true){ (err) in
            if err != nil{
                //self.loading = false
                return
            }
            //self.loading = false
            self.hasRequest = false
            self.isAvailible = false
        }
    }
}
