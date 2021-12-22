//
//  CardSelectView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 22/12/21.
//

import SwiftUI

struct CardSelectView: View {
    @State var legenda: String = "Casa"
    @State var local: String = "Viana"
    @State var icon: String = "icon_home"
    
    var body: some View {
        HStack(spacing: 13){
            Image(icon)
                .padding(.leading, 14)
            
            VStack(alignment: .leading){
                Text(legenda)
                    .font(Font.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color.accentColor)
                
                Text(local)
                    .font(Font.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color("TextoColor"))
            }
        }
        .frame(minWidth: 173, minHeight: 65, alignment: .leading)
        .background(Color("CardSelectFundo"))
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color("CardSelectBoder"), lineWidth: 2))
    }
}

struct CardSelectView_Previews: PreviewProvider {
    static var previews: some View {
        CardSelectView()
    }
}
