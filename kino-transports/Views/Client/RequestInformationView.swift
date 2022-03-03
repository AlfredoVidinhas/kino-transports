//
//  RequestInformationView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 03/03/22.
//

import SwiftUI

struct RequestInformationView: View {
    var body: some View {
        VStack{
            HStack{
                Image("foto_perfil")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 57)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.accentColor, lineWidth: 1))
                
                VStack (alignment: .leading){
                    Text("Mirian Filipe")
                        .font(Font.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color("TextoColor"))
                    Text("Matricula:  LD-23-45-HB")
                        .font(Font.custom("Poppins-Regular", size: 15))
                        .foregroundColor(Color("TextoColor").opacity(0.5))
                }
                
                Spacer()
                
                Image("icon_aceder")
                    .frame(height: 38)
            }
            
            Image("medio_carro")
                .resizable()
                .scaledToFit()
                .frame(height: 78)
                .padding(.vertical, 15)
            
            HStack{
                Text("Toyota")
                    .font(Font.custom("Poppins-Medium", size: 20))
                    .foregroundColor(Color("TextoColor"))
                
                Spacer()
                
                Text("10.000 AKZ")
                    .font(Font.custom("Poppins-Medium", size: 20))
                    .foregroundColor(Color("TextoColor"))
            }.padding(.vertical, 2)
            HStack{
                Text("Lugares")
                    .font(Font.custom("Poppins-Regular", size: 15))
                    .foregroundColor(Color("TextoColor"))
                
                Spacer()
                
                Text("3 Pessoas")
                    .font(Font.custom("Poppins-Regular", size: 15))
                    .foregroundColor(Color("TextoColor"))
            }.padding(.vertical, 2)
            HStack{
                Text("Altura")
                    .font(Font.custom("Poppins-Regular", size: 15))
                    .foregroundColor(Color("TextoColor"))
                
                Spacer()
                
                Text("5 metros")
                    .font(Font.custom("Poppins-Regular", size: 15))
                    .foregroundColor(Color("TextoColor"))
            }.padding(.vertical, 2)
            HStack{
                Text("Tempo Chegada")
                    .font(Font.custom("Poppins-Regular", size: 15))
                    .foregroundColor(Color("TextoColor"))
                
                Spacer()
                
                Text("25 mins")
                    .font(Font.custom("Poppins-Regular", size: 15))
                    .foregroundColor(Color("TextoColor"))
            }.padding(.vertical, 2)
            ExDivider()
        }
        .frame(maxWidth: .infinity, minHeight: 300)
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(Color("FundoColor"))
    }
}

struct RequestInformationView_Previews: PreviewProvider {
    static var previews: some View {
        RequestInformationView()
    }
}
