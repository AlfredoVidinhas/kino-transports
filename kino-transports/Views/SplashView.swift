//
//  ContentView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 15/11/2021.
//

import SwiftUI
import Combine

struct SplashView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Color.accentColor
                .ignoresSafeArea()
                
                VStack(alignment: .center){
                    Image("logo_white")
                        .resizable()
                        .padding(.top, 60)
                        .offset(y: -60)
                        .frame(maxWidth: 185, maxHeight: 168)
                        
                    Spacer()
                    
                    Button(action: {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }, label: {
                        NavigationLink(destination: NumberPhoneView().navigationBarHidden(true), label: {
                            Text("Começar a Explorar")
                                .frame(maxWidth: .infinity, maxHeight: 56)
                                .foregroundColor(Color("BotaoTextoColor"))
                                .font(Font.custom("Poppins-Medium", size: 18))
                                .background(Color.white)
                                .cornerRadius(16)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 20)
                        })
                    })
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
