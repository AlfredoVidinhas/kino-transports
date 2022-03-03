//
//  RequestClientView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 03/03/22.
//

import SwiftUI
import CoreLocation
import MapKit
import Firebase
import Combine

struct RequestClientView: View {
    @ObservedObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion.defaultRegion
    @State private var cancellable: AnyCancellable?
    
    @StateObject var mapModel = MapViewModel()
    @StateObject var requestModel = RequestViewModel()
    
    var body: some View {
        VStack{
            ZStack(alignment: .bottom){
                ZStack{
                    MapView(mapModel: mapModel)
                }
                
                HStack{
                    Spacer()
                    
                    Button(action: {
                        withAnimation{
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                            setCurrentLocation()
                        }
                    }, label: {
                        Image("icon_current_location")
                            .frame(width: 38, height: 38)
                            .background(Color.accentColor)
                            .clipShape(Circle())
                            .background(Circle())
                            .shadow(color: Color("Shadow"), radius: 15, x: 0, y: 10)
                    })
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                
            }
            
            RequestInformationView()
        }
        .ignoresSafeArea()
        .onAppear{
            setCurrentLocation()
        }
    }
    
    private func setCurrentLocation() {
        cancellable = locationManager.$location.sink { location in
            mapModel.isDragMap = false
            mapModel.currentLocation = nil
            mapModel.currentLocation = location?.coordinate ?? CLLocationCoordinate2D()
        }
    }
}

struct RequestClientView_Previews: PreviewProvider {
    static var previews: some View {
        RequestClientView()
    }
}
