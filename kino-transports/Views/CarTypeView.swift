//
//  CarTypeView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 11/01/22.
//

import SwiftUI

struct CarTypeView: View {
    @State var currentIndex = 2
    @StateObject var mapModel = MapViewModel()
    
    var body: some View {
        CustomNavigationContainerView {
            VStack {
                ScrollView(showsIndicators: false) {
                    CardTypeView {
                        HStack {
                            VStack {
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(Color.accentColor)
                                
                                VLineView()
                                    .stroke(Color("TextoColor").opacity(0.2) , style: StrokeStyle(lineWidth: 1, dash: [3]))
                                    .frame(width: 1, height: 59)
                                
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(Color("EndPoint"))
                            }
                            .offset(y: -15)
                            .padding(.trailing, 4)
                            
                            VStack (alignment: .leading){
                                Text("Ponto de Partida")
                                    .font(Font.custom("Poppins-Regular", size: 12))
                                    .foregroundColor(Color("TextoColor").opacity(0.6))
                                    .padding(.bottom, 1)
                                
                                Text(mapModel.getStartName())
                                    .font(Font.custom("Poppins-Medium", size: 15))
                                    .foregroundColor(Color("TextoColor"))
                                    .padding(.bottom, 10)
                                
                                ExDivider()
                                
                                Text("Ponto de destino")
                                    .font(Font.custom("Poppins-Regular", size: 12))
                                    .foregroundColor(Color("TextoColor").opacity(0.6))
                                    .padding(.top, 10)
                                    .padding(.bottom, 1)
                                
                                Text(mapModel.getDestinationName())
                                    .font(Font.custom("Poppins-Medium", size: 15))
                                    .foregroundColor(Color("TextoColor"))
                            }
                            
                            Spacer()
                        }
                        .padding(.vertical, 30)
                        .padding(.horizontal, 21)
                    }
                    .padding(.bottom, 47)
                    
                    CardTypeView {
                        VStack {
                            Text("Selecione um carro")
                                .font(Font.custom("Poppins-Medium", size: 17))
                                .foregroundColor(Color("TextoColor"))
                                .padding(.bottom, 20)
                            
                            HStack {
                                CardSelectCarView(title: "Grande", icon: "grande_carro", index: 1, currentIndex: $currentIndex)
                                Spacer()
                                CardSelectCarView(title: "Medio", icon: "medio_carro", index: 2, currentIndex: $currentIndex)
                                Spacer()
                                CardSelectCarView(title: "Pequeno", icon: "pequeno_carro", index: 3, currentIndex: $currentIndex)
                            }
                            .padding(.bottom, 30)
                            
                            ExDivider()
                            
                            HStack {
                                Text("Preço: ")
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color("TextoColor").opacity(0.6))
                                
                                Text(mapModel.calculatePrice(typeCar: currentIndex))
                                    .font(Font.custom("Poppins-Medium", size: 16))
                                    .foregroundColor(Color("TextoColor"))
                            }
                            .padding(.top, 5)
                        }
                        .padding(.vertical, 17)
                        .padding(.horizontal, 21)
                    }.padding(.bottom, 20)
                }
                
                
                Spacer()
                
                Button(action: {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    
                }, label: {
                    ButtonView(text: "Pedir Kino")
                })
            }
            .customNavigationTitle("Tipo de carro")
        }
    }
}

struct CardTypeView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
        .frame(maxWidth: .infinity, minHeight: 194, alignment: .top)
        .background(Color("CinzaColor"))
        .border(Color("BorderCinzaColor"), cornerRadius: 24)
        .padding(.horizontal, 20)
        .shadow(color: Color.black.opacity(0.06), radius: 18, x: 0, y: 15)
    }
}

struct CardSelectCarView: View {
    @State var title: String = "Grande"
    @State var icon: String = "grande_carro"
    @State var index = 0
    @Binding var currentIndex: Int
    
    var body: some View {
        VStack {
            HStack {
                Image(icon)
            }
            .frame(width: 75, height: 75)
            .background(LinearGradient(gradient: Gradient(colors: [Color("TerceiraColor"), .accentColor]), startPoint: .top, endPoint: .bottom).opacity(currentIndex == index ? 1 : 0))
            .border(Color("TextoColor").opacity(0.26), width: 1, cornerRadius: 13)
            
            Text(title)
                .font(Font.custom("Poppins-Medium", size: 14))
                .foregroundColor(Color("TextoColor"))
                .padding(.top, 5)
            
        }.onTapGesture {
            withAnimation {
                currentIndex = index
            }
        }
    }
}

struct CarTypeView_Previews: PreviewProvider {
    static var previews: some View {
        CarTypeView()
    }
}
