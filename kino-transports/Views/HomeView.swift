//
//  HomeView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 21/12/21.
//

import SwiftUI
import CoreLocation
import MapKit
import Firebase

struct HomeView: View {
    @AppStorage("log_Status") var status = false
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.334_900,
                                           longitude: -122.009_020),
            latitudinalMeters: 750,
            longitudinalMeters: 750
        )
    
    var body: some View {
        VStack{
            ZStack{
                Map(coordinateRegion: $region)
                
                HStack{
                    
                }
            }
            
            VStack{
                VStack{
                    SearchStatusView()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 28){
                            CardSelectView(legenda: "Casa", local: "Viana", icon: "icon_home")
                            CardSelectView(legenda: "Trabalho", local: "Trinta Praça", icon: "icon_home")
                        }
                        .padding(.leading, 5)
                        .padding(.trailing, 20)
                    }
                    .padding(.leading, 15)
                    .padding(.bottom, 20)
                    
                    Button(action: {
                        do{
                            try Auth.auth().signOut()
                            withAnimation{status = false}
                        }
                        catch{
                            print("Fail: \(error)")
                        }
                    }, label: {
                        ButtonView(text: "Confirmar")
                    })
                }
                .frame(maxWidth: .infinity, minHeight: 300)
                .background(Color("FundoColor"))
            }
        }.ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
