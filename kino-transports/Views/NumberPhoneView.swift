//
//  NumberPhoneView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 20/12/21.
//

import SwiftUI
import Combine

struct NumberPhoneView: View {
    @State private var numOfPeople = ""
    @StateObject var loginData = LoginViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("Digite o seu \nNúmero de telefone")
                        .font(Font.custom("Poppins-Regular", size: 23))
                        .foregroundColor(Color("TextoColor"))
                        .multilineTextAlignment(.leading)
                        .lineSpacing(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Text("+244")
                            .font(Font.custom("Poppins-Regular", size: 18))
                            .foregroundColor(Color("TextoColor"))
                            .overlay(ExDivider().offset(x: 0, y: 20))
                            .padding(.trailing, 20)
                        
                        TextField("Número de Telefone", text: $loginData.phoneNumber)
                            .font(Font.custom("Poppins-Regular", size: 18))
                            .foregroundColor(Color("TextoColor"))
                            .overlay(ExDivider().offset(x: 0, y: 20))
                            .keyboardType(.numberPad)
                            .onReceive(Just(loginData.phoneNumber)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.loginData.phoneNumber = filtered
                                }
                            }
                    }.padding(.top, 50)
                    
                    Text("Receberá um código de \nconfirmação em seu número de telefone")
                        .font(Font.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color("TextoColor"))
                        .lineSpacing(2)
                        .padding(.top, 15)
                }
                .padding(.horizontal, 20)
                .offset(y: 30)
                
                Spacer()
                
                NavigationLink(destination: ConfirmCodeView(loginData: loginData), isActive: $loginData.gotoVerify) {
                    Text("")
                        .hidden()
                }
                
                Button(action: {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    loginData.sendCode()
                }, label: {
                    ButtonView(text: "Continuar")
                })
                
            }
            
            if loginData.loading{
                LoadingView(show: .constant(true), placeHolder: "Enviando...")
            }
        }
    }
}

struct NumberPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPhoneView()
    }
}
