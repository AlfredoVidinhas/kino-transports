//
//  EmailPhoneView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 20/12/21.
//

import SwiftUI
import Combine

struct EmailPhoneView: View {
    @State private var numOfPeople = ""
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("Digite o seu \nEmail")
                        .font(Font.custom("Poppins-Regular", size: 23))
                        .foregroundColor(Color("TextoColor"))
                        .multilineTextAlignment(.leading)
                        .lineSpacing(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("Email", text: $numOfPeople)
                        .font(Font.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Color("TextoColor"))
                        .overlay(ExDivider().offset(x: 0, y: 20))
                        .keyboardType(.numberPad)
                        .onReceive(Just(numOfPeople)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.numOfPeople = filtered
                            }
                    }.padding(.top, 50)
                    
                    Text("Receberá um código de \nconfirmação em seu email")
                        .font(Font.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color("TextoColor"))
                        .lineSpacing(2)
                        .padding(.top, 15)
                }
                .padding(.horizontal, 20)
                .offset(y: 30)
                
                Spacer()
                
                Button(action: {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                }, label: {
                    NavigationLink(destination: ConfirmCodeView(), label: {
                        Text("Continuar")
                            .frame(maxWidth: .infinity, maxHeight: 56)
                            .foregroundColor(Color.white)
                            .font(Font.custom("Poppins-Medium", size: 18))
                            .background(Color.accentColor)
                            .cornerRadius(16)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                    })
                })
                
            }
        }
    }
}

struct EmailPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        EmailPhoneView()
    }
}
