//
//  HomeStartPointUIView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 11/01/22.
//

import SwiftUI

struct HomeStartPointUIView: View {
    @StateObject var mapModel = MapViewModel()
    
    var body: some View {
        VStack{
            SearchStatusView(text: mapModel.streetName)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 28){
                    CardSelectView(legenda: "Casa", local: "Viana", icon: "icon_home")
                    CardSelectView(legenda: "Trabalho", local: "Trinta Praça", icon: "icon_home")
                }
                .padding(.leading, 5)
                .padding(.trailing, 20)
            }
            .padding(.leading, 15)
            .padding(.bottom, 20)
            
            Button(action: {
                /*do{
                    try Auth.auth().signOut()
                    withAnimation{status = false}
                }
                catch{
                    print("Fail: \(error)")
                }*/
                mapModel.defineStartPoint()
            }, label: {
                ButtonView(text: "Confirmar")
            })
        }
        .frame(maxWidth: .infinity, minHeight: 300)
        .background(Color("FundoColor"))
    }
}

struct HomeStartPointUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStartPointUIView()
    }
}
