//
//  CustomNavView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 27/01/22.
//

import SwiftUI

struct CustomNavView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            CustomNavigationContainerView {
                content
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CustomNavView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            VStack {
                Text("Hello, world")
            }
        }
    }
}
