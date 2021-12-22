//
//  LoadingView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 22/12/21.
//

import SwiftUI

struct LoadingView: View {
    @Binding var show: Bool
    @State var animate = false
    var placeHolder: String
    
    var body: some View {
        VStack(spacing: 28){
            Circle()
                .stroke(AngularGradient(gradient: .init(colors: [Color.primary, Color.primary.opacity(0)]), center: .center))
                .frame(width: 80, height: 80)
                .rotationEffect(.init(degrees: animate ? 360 : 0))
                .animation(Animation.linear(duration: 1.2).repeatForever(autoreverses: false), value: animate)
            
            Text(placeHolder)
                .fontWeight(.bold)
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 35)
        .background(BlurView())
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.primary.opacity(0.35)
        )
        .onAppear{
            animate.toggle()
        }
        .ignoresSafeArea()
    }
}


//background

struct BlurView : UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(show: .constant(true), placeHolder: "Enviando...")
    }
}
