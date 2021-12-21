//
//  HomeView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 21/12/21.
//

import SwiftUI
import CoreLocation
import MapKit

struct HomeView: View {
    
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.334_900,
                                           longitude: -122.009_020),
            latitudinalMeters: 750,
            longitudinalMeters: 750
        )
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $region)
            
            VStack{
                HStack{
                    
                }
                
                Spacer()
                
                VStack{
                    HStack{
                        HStack{
                            Circle().frame(width: 9, height: 9)
                            Text("Qual o ponto de partida?")
                        }
                        Spacer()
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: 56)
                    .background(Color("CinzaColor"))
                    .cornerRadius(4)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity, minHeight: 300)
                .background(Color.white)
                
                
            }
        }.ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
