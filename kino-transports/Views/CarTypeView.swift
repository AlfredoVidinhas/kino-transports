//
//  CarTypeView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 11/01/22.
//

import SwiftUI

struct CarTypeView: View {
    @StateObject var mapModel = MapViewModel()
    @StateObject var requestModel = RequestViewModel()
    
    var body: some View {
        ZStack{
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
                                    CardSelectCarView(title: "Grande", icon: "grande_carro", index: 3, currentIndex: $requestModel.carIndex)
                                    Spacer()
                                    CardSelectCarView(title: "Medio", icon: "medio_carro", index: 2, currentIndex: $requestModel.carIndex)
                                    Spacer()
                                    CardSelectCarView(title: "Pequeno", icon: "pequeno_carro", index: 1, currentIndex: $requestModel.carIndex)
                                }
                                .padding(.bottom, 30)
                                
                                ExDivider()
                                
                                HStack {
                                    Text("Preço: ")
                                        .font(Font.custom("Poppins-Regular", size: 16))
                                        .foregroundColor(Color("TextoColor").opacity(0.6))
                                    
                                    Text(requestModel.calculatePrice())
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
                        requestModel.requestCar(from: self.mapModel.getStarGeoPoint(), to: self.mapModel.getDestinationGeoPoint(), fromTitle: self.mapModel.getStartName(), toTitle: self.mapModel.getDestinationName())
                    }, label: {
                        ButtonView(text: "Pedir Kino")
                    })
                }
                .customNavigationTitle("Tipo de carro")
            }
            
            NavigationLink(destination: RequestClientView(requestModel: requestModel).navigationBarHidden(true), isActive: $requestModel.requestAccept) {
                EmptyView()
            }
            
            if requestModel.loading {
                ResquestLoader(buttonCancel: {requestModel.cancelRequest()})
            }
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

struct ResquestLoader: View {
    @State var show = false
    var buttonCancel: () -> Void
    
    var body: some View {
        GeometryReader {geometry in
            VStack(spacing: 20) {
                Text("Solicitando um Kino")
                    .font(Font.custom("Poppins-Medium", size: 20))
                    .foregroundColor(Color("TextoColor"))
                
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 4,lineCap: .round))
                    .frame(width: 30, height: 30)
                    .rotationEffect(.init(degrees: self.show ? 360 : 0))
                    .padding(.vertical, 20)
                    .onAppear{
                        withAnimation(Animation.default.speed(0.45).repeatForever(autoreverses: false)){
                            self.show.toggle()
                        }
                    }
                
                Button(action: {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    self.buttonCancel()
                }, label: {
                    ButtonView(text: "Cancelar Kino")
                })
            }
            .padding(.top, 25)
            .padding(.bottom, 5)
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(12)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
        }
        .padding(.horizontal, 40)
        .background(BlurView(blurEffect: .constant(.systemUltraThinMaterial)).edgesIgnoringSafeArea(.all))
    }
}

struct CarTypeView_Previews: PreviewProvider {
    static var previews: some View {
        CarTypeView()
    }
}
