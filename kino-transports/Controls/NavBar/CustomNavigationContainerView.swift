//
//  CustomNavigationContainerView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 27/01/22.
//

import SwiftUI

struct CustomNavigationContainerView<Content: View>: View {
    let content: Content
    @State private var title: String = "Titilo Header"
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            CustomNavigationView(title: title)
            Spacer()
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self) { value in
            self.title = value
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
