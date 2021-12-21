//
//  ButtonView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 21/12/21.
//

import SwiftUI

struct ButtonView: View {
    @State var text: String = ""
    
    var body: some View {
        Text(text)
            .frame(maxWidth: .infinity, maxHeight: 56)
            .foregroundColor(Color.white)
            .font(Font.custom("Poppins-Medium", size: 18))
            .background(Color.accentColor)
            .cornerRadius(16)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .shadow(color: Color("Shadow"), radius: 30, x: 0, y: 15)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "Button")
    }
}
