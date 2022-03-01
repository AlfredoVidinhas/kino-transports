//
//  MenuView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 28/12/21.
//

import SwiftUI
import Firebase

struct MenuView: View {
    @Binding var showMenu: Bool
    @Binding var userInfo: UserModel
    
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        ZStack{
            Color("MenuFundo")
            .ignoresSafeArea()
            
            VStack(alignment: .leading){
                Button(action: {
                    withAnimation{
                        self.showMenu = false
                    }
                }, label: {
                    Image("icon_close")
                        .frame(width: 33, height: 33)
                        .background(Color.accentColor)
                        .clipShape(Circle())
                        .background(Circle())
                        .shadow(color: Color("Shadow"), radius: 15, x: 0, y: 10)
                        .padding(.leading, 20)
                })
                
                VStack{
                    Image("foto_perfil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 105)
                        .clipShape(Circle())
                        .padding(10)
                        .overlay(Circle().stroke(Color.accentColor, lineWidth: 3))
                        .shadow(color: Color("Shadow"), radius: 15, x: 0, y: 10)
                    
                    Text(self.userInfo.userName)
                        .font(Font.custom("Poppins-SemiBold", size: 18))
                        .foregroundColor(Color("TextoColor"))
                        .padding(.top, 13)
                    
                    Text(verbatim: self.userInfo.phoneNumber)
                        .font(Font.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color("TextoColor").opacity(0.6))
                        .padding(.top, -12)
                    
                    ExDivider()
                        .padding()
                    
                    VStack{
                        
                        Button(action: {
                            do{
                                try Auth.auth().signOut()
                                withAnimation{status = false}
                            }
                            catch{
                                print("Fail: \(error)")
                            }
                        }, label: {
                            ButtonView(text: "Sair")
                        })
                    }
                    
                }
                .padding(.top)
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(.top, UIDevice.current.hasTopNotch ? 3 : 15)
        }
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(showMenu: .constant(false), userInfo: .constant(UserModel(userName: "Alfredo Vidinhas", email: "alfredo@gmail.com", phoneNumber: "", isDriver: false, dateCreated: Date())))
    }
}
