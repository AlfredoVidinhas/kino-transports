//
//  CustomNavigationView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 27/01/22.
//

import SwiftUI

struct CustomNavigationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var tittle: String = "Titilo Header"
    
    var body: some View {
        HStack{
            backButton
            titleSection
            Spacer()
        }
    }
}

struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            CustomNavigationView()
            Spacer()
        }
    }
}

extension CustomNavigationView {
    private var backButton: some View {
        Button(action: {
            withAnimation{
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
                presentationMode.wrappedValue.dismiss()
            }
        }, label: {
            Image(systemName: "chevron.left")
                .accentColor(.white)
                .font(.system(size: 20, weight: .bold))
                .frame(width: 40, height: 40)
                .background(Color.accentColor)
                .clipShape(Circle())
                .background(Circle())
                .shadow(color: Color("Shadow"), radius: 15, x: 0, y: 10)
                .padding(.leading, 20)
        })
    }
    
    private var titleSection: some View {
        VStack {
            Text(tittle)
                .font(Font.custom("Poppins-Medium", size: 24))
                .foregroundColor(Color("TextoColor"))
                .padding(.leading, 20)
        }
    }
}
