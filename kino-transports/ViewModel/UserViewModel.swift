//
//  UserViewModel.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 29/12/21.
//

import SwiftUI
import Firebase

class UserViewModel : ObservableObject{
    @Published var userInfo = UserModel(userName: "", email: "", isDriver: false, dateCreated: Date())
    
    let ref = Firestore.firestore()
    let uid = Auth.auth().currentUser!.uid
    
    init(){
        fetchUser()
    }
    
    func fetchUser(){
        ref.collection("Users").document(uid).getDocument{ document, err in
            guard let user = document else{return}
            
            let userName = user.data()?["userName"] as! String
            let email = user.data()?["email"] as! String
            let isDriver = user.data()?["isDriver"] as! Bool
            //let dateCreated = user.data()?["dateCreated"] as! Timestamp
            
            DispatchQueue.main.async {
                self.userInfo = UserModel(userName: userName, email: email, isDriver: isDriver, dateCreated: Date())
            }
            
        }
    }
}
