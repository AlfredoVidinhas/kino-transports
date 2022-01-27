//
//  CustomNavigationContainerView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 27/01/22.
//

import SwiftUI

struct CustomNavigationContainerView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            CustomNavigationView()
            Spacer()
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct CustomNavigationContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationContainerView {
            VStack {
                Text("Hello, world")
            }
        }
    }
}
