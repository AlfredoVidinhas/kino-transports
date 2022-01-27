//
//  CustomNavLink.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 27/01/22.
//

import SwiftUI

struct CustomNavLink<Label: View, Destination: View>: View {
    let destination: Destination
    let label: Label
    
    init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        NavigationLink(
            destination: {
                CustomNavigationContainerView(content: {
                    destination
                }).navigationBarHidden(true)
            },
            label: {
                label
            })
    }
}

struct CustomNavLink_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            CustomNavLink(
                destination: Text("Destination").customNavigationTitle("Destination")) {
                    Text("Click Here")
            }
            .customNavigationTitle("Tela de teste")
        }
    }
}
