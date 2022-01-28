//
//  VLineView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 28/01/22.
//

import SwiftUI

struct VLineView: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        }
    }
}

struct VLineView_Previews: PreviewProvider {
    static var previews: some View {
        VLineView()
    }
}
