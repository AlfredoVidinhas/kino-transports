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
    
    @StateObject var userData = UserViewModel()
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView {
                ZStack{
                    HomeView(showMenu: self.$show).navigationBarHidden(true)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.white)
                .disabled(self.show ? true : false)
                .blur(radius: self.show ? 5 : 0)
                .offset(x: self.show ? geometry.size.width / 1.3 : 0, y: 0)
            }
            
            if self.show{
                MenuView(showMenu: self.$show, userInfo: self.$userData.userInfo)
                    .frame(width: geometry.size.width/1.3)
                    .background(Color("TextoColor").blur(radius: 2).opacity(0.05).offset(x: 1, y: 0).ignoresSafeArea())
                    .transition(.move(edge: .leading))
            }
        }.gesture(
            DragGesture()
                .onEnded{
                    if $0.translation.width < -100 {
                        withAnimation {
                            self.show = false
                        }
                    }
                }
        )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
