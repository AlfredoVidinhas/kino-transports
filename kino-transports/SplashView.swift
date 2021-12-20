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

struct NumberPhoneView: View {
    @State private var numOfPeople = ""
    
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
                        
                        TextField("Número de Telefone", text: $numOfPeople)
                            .font(Font.custom("Poppins-Regular", size: 18))
                            .foregroundColor(Color("TextoColor"))
                            .overlay(ExDivider().offset(x: 0, y: 20))
                            .keyboardType(.numberPad)
                            .onReceive(Just(numOfPeople)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.numOfPeople = filtered
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
                
                Button(action: {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                }, label: {
                    NavigationLink(destination: NumberPhoneView(), label: {
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

struct ExDivider: View {
    let color: Color = Color("BoderColor")
    let width: CGFloat = 1
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
        NumberPhoneView()
    }
}