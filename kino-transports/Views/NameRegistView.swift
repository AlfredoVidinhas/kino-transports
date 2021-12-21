//
//  NameRegistView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 21/12/21.
//

import SwiftUI
import Combine

struct NameRegistView: View {
    @State private var numOfPeople = ""
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("Perfeito!")
                        .font(Font.custom("Poppins-Medium", size: 25))
                        .foregroundColor(Color("TextoColor"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("E por ultimo, Qual é o seu nome?")
                        .font(Font.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Color("TextoColor"))
                        .frame(maxWidth: .infinity, alignment: .leading)
            
                    TextField("Primeiro e ultimo nome", text: $numOfPeople)
                        .font(Font.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Color("TextoColor"))
                        .overlay(ExDivider().offset(x: 0, y: 20))
                        .keyboardType(.namePhonePad)
                        .onReceive(Just(numOfPeople)) { newValue in
                    }.padding(.top, 50)
                    
                }
                .padding(.horizontal, 20)
                .offset(y: 30)
                
                Spacer()
                
                Button(action: {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                }, label: {
                    NavigationLink(destination: HomeView().navigationBarHidden(true), label: {
                        ButtonView(text: "Chamar um Kino")
                    })
                })
                
            }
        }
    }
}

struct NameRegistView_Previews: PreviewProvider {
    static var previews: some View {
        NameRegistView()
    }
}
