//
//  ConfirmCodeView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 20/12/21.
//

import SwiftUI

struct ConfirmCodeView: View {
    @State private var isOtpMatching = false
    @State private var codeNum = "1234"
    
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    Text("O código foi enviado para")
                        .font(Font.custom("Poppins-Regular", size: 18))
                        .foregroundColor(Color("TextoColor"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("alfredo@gmail.com")
                        .font(Font.custom("Poppins-Medium", size: 18))
                        .foregroundColor(Color("TextoColor"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack{
                        OTPTextFieldView { otp, completionHandler in
                            if otp == "1234" { // this could be a network call
                                completionHandler(true)
                                isOtpMatching = true
                            } else {
                                completionHandler(false)
                                isOtpMatching = false
                            }
                        }
                    }.padding(.vertical, 40)
                    
                    
                }.padding(.horizontal, 20)
                .offset(y: -35)
                
                Spacer()
                
                Button(action: {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                }, label: {
                    NavigationLink(destination: NameRegistView().navigationBarHidden(true), label: {
                        ButtonView(text: "Avançar")
                    }).disabled(!isOtpMatching)
                })
            }
            
        }
    }
}

struct ConfirmCodeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ConfirmCodeView()
        }
    }
}
