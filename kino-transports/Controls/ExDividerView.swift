//
//  ExDividerView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 20/12/21.
//

import SwiftUI

struct ExDivider: View {
    let color: Color = Color("BoderColor")
    let width: CGFloat = 1
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct ExDividerView_Previews: PreviewProvider {
    static var previews: some View {
        ExDivider()
    }
}
