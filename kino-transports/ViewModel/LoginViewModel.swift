//
//  LoginViewModel.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 22/12/21.
//

import SwiftUI
import Firebase

class LoginViewModel: ObservableObject{
    @Published var phoneNumber = ""
    @Published var code = ""
    
    // DataModel country Error View...
    @Published var errorMsg = ""
    @Published var error = false
    
    // stroing CODE for verification
    @Published var CODE = ""
    @Published var gotoVerify = false
    @Published var loading = false
    
    @Published var registerUser = false
    
    // user logged Status
    @AppStorage("log_Status") var status = false
    
    // sending code to user
    func sendCode(){
        print("passou")
        
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        loading = true
        let number = "+244\(phoneNumber)"
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { CODE, err in
            
            self.loading = false
            
            if let error = err{
                self.errorMsg = error.localizedDescription
                self.error.toggle()
                return
            }
            
            self.CODE = CODE ?? ""
            self.gotoVerify = true
            print("passou: \(self.CODE)")
        }
    }
    
    func verifyCode(){
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)
        
        loading = true
        
        Auth.auth().signIn(with: credential) { result, err in
            
            if let error = err{
                self.errorMsg = error.localizedDescription
                self.error.toggle()
                return
            }
            
            // else user logged in Successfully
            print("passou: \(self.status)?????")
            self.checkUser()
        }
    }
    
    func checkUser(){
        let ref = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        
        ref.collection("Users").document(uid).getDocument { document, err in
            
            self.loading = false
            
            if let document = document, document.exists {
                self.status = true
            } else {
                self.registerUser.toggle()
            }
            
            return
        }
    }
}
