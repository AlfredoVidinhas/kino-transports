//
//  MainView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 27/12/21.
//

import SwiftUI

struct MainView: View {
    
    @State var index = 0
    @State var show = false
    
    var body: some View {
        ZStack{
            Color("MenuFundo")
            .ignoresSafeArea()
            
            VStack(alignment: .leading){
                Button(action: {}, label: {
                    Image("icon_close")
                        .frame(width: 40, height: 40)
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
                        .padding(.leading, 20)
                    
                    Text("Alfredo Vidinhas")
                        .font(Font.custom("Poppins-SemiBold", size: 18))
                        .foregroundColor(Color("MenuTexto"))
                        .padding(.top, 13)
                    
                    Text(verbatim: "alfredo@gmail.com")
                        .font(Font.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color("MenuTexto").opacity(0.6))
                        .padding(.top, -12)
                    
                    ExDivider()
                        .frame(width: 210)
                        .padding()
                    
                    
                    
                }
                .padding(.top)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            VStack{
                GeometryReader{_ in
                    VStack{
                        HomeView()
                    }
                }
            }
            .background(.white)
            .cornerRadius(self.show ? 30 : 0)
            .scaleEffect(self.show ? 0.9 : 1)
            .offset(x: self.show ? UIScreen.main.bounds.width / 1.4 : 0, y: self.show ? 15 : 0)
            .rotationEffect(.init(degrees: self.show ? 0 : 0))
            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
