//
//  RequestModalView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 01/03/2022.
//

import SwiftUI

struct RequestModalView: View {
    var buttonAccept: () -> Void
    var pontoPartida = "Partida"
    var pontoDestino = "Destino"
    
    var body: some View {
        GeometryReader {geometry in
            VStack(spacing: 20) {
                Text("Corrida")
                    .font(Font.custom("Poppins-Medium", size: 20))
                    .foregroundColor(Color("TextoColor"))
                
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
                        
                        Text(pontoPartida)
                            .font(Font.custom("Poppins-Medium", size: 15))
                            .foregroundColor(Color("TextoColor"))
                            .padding(.bottom, 10)
                        
                        ExDivider()
                        
                        Text("Ponto de destino")
                            .font(Font.custom("Poppins-Regular", size: 12))
                            .foregroundColor(Color("TextoColor").opacity(0.6))
                            .padding(.top, 10)
                            .padding(.bottom, 1)
                        
                        Text(pontoDestino)
                            .font(Font.custom("Poppins-Medium", size: 15))
                            .foregroundColor(Color("TextoColor"))
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
                
                
                Button(action: {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    self.buttonAccept()
                }, label: {
                    ButtonView(text: "Aceitar Corrida")
                })
            }
            .padding(.top, 25)
            .padding(.bottom, 5)
            .background(Color.white)
            .cornerRadius(12)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
        }
        .padding(.horizontal, 40)
        .background(BlurView(blurEffect: .constant(.systemUltraThinMaterial)).edgesIgnoringSafeArea(.all))
    }
}

struct RequestModalView_Previews: PreviewProvider {
    static var previews: some View {
        RequestModalView(buttonAccept: {})
    }
}
