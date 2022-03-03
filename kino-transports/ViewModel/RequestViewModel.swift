//
//  RequestViewModel.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 01/03/2022.
//

import SwiftUI
import CoreLocation
import Firebase

class RequestViewModel: ObservableObject {
    @Published var carIndex = 2
    @Published var from: GeoPoint?
    @Published var to: GeoPoint?
    @Published var loading = false
    @Published var requestAccept = false
    @Published var docId = ""
    
    let ref = Firestore.firestore()
    let uid = Auth.auth().currentUser!.uid
    
    init() {
    }
    
    func calculatePrice() -> String {
        return String(5000*carIndex) + " AKZ"
    }
    
    func requestCar(from: GeoPoint, to: GeoPoint, fromTitle: String, toTitle: String) {
        loading = true
        
        let doc = self.ref.collection("Corridas").document()
        self.docId = doc.documentID
        
        self.from = from
        self.to = to
        
        doc.setData([
            "from": from,
            "to": to,
            "cliente": self.uid,
            "active": true,
            "tipoCarro": self.carIndex,
            "motorista": "",
            "preco": self.calculatePrice(),
            "fromTitle": fromTitle,
            "toTitle": toTitle
        ]){ (err) in
            if err != nil{
                self.loading = false
                return
            }
            //self.loading = false
            
            self.ref.collection("Corridas").whereField("motorista", isNotEqualTo: "").addSnapshotListener {(snap, err) in
                if err != nil {
                    self.loading = false
                    print((err?.localizedDescription)!)
                    return
                }
                
                let requests = snap?.documents
                
                if(requests!.count > 0){
                    let data = requests![0].data()
                    self.requestAccept = true
                }
            }
        }
    }
    
    func cancelRequest() {
        self.ref.collection("Corridas").document(self.docId).delete{ (err) in
            if err != nil{
                print("Error while cancelling!")
                return
            }
            
            self.loading = false
        }
    }
}
