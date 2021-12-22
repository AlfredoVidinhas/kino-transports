//
//  SearchStatusView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 22/12/21.
//

import SwiftUI

struct SearchStatusView: View {
    var body: some View {
        HStack{
            HStack(spacing: 12){
                Circle()
                    .frame(width: 9, height: 9)
                    .foregroundColor(Color.accentColor)
                    .padding(.leading)
                
                Text("Qual o ponto de partida?")
                    .font(Font.custom("Poppins-Regular", size: 17))
                    .foregroundColor(Color("TextoColor"))
                
                Spacer()
                
                Image("icon_search")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
                    .padding(.trailing, 5)
            }
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: 56)
        .background(Color("CinzaColor"))
        .cornerRadius(4)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}

struct SearchStatusView_Previews: PreviewProvider {
    static var previews: some View {
        SearchStatusView()
    }
}
