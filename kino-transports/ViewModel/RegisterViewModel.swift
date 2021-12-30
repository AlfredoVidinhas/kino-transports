//
//  RegisterViewModel.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 29/12/21.
//

import SwiftUI
import Firebase

class RegisterViewModel: ObservableObject{
    @Published var userName = ""
    
    @Published var loading = false
    
    @AppStorage("log_Status") var status = false
    
    func registerUser(){
        loading = true
        
        let ref = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        
        ref.collection("Users").document(uid).setData([
            "uid": uid,
            "userName": self.userName,
            "email": "",
            "dateCreated": Date(),
            "isDriver": false
        ]){ (err) in
            if err != nil{
                self.loading = false
                return
            }
            self.loading = false
            self.status = true
        }
    }
}
