//
//  HomeDriverView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 01/03/2022.
//

import SwiftUI
import CoreLocation
import MapKit
import Combine

struct HomeDriverView: View {
    @Binding var showMenu: Bool
    @ObservedObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion.defaultRegion
    @State private var cancellable: AnyCancellable?
    
    @StateObject var mapModel = MapViewModel()
    @StateObject var driverModel = DriverViewModel()
    
    var body: some View {
        VStack{
            ZStack (alignment: .bottom){
                ZStack{
                    MapView(mapModel: mapModel)
                    Image("icon_pin_init").offset(y: -27)
                }
                
                HStack {
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
                
                if driverModel.hasRequest {
                    RequestModalView(buttonAccept: {})
                }
            }
        }
        .ignoresSafeArea()
        .safeAreaInset(edge: .top, alignment: .leading){
            Button(action: {
                withAnimation{
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    self.showMenu = true
                }
            }, label: {
                Image("icon_menu")
                    .frame(width: 40, height: 40)
                    .background(Color.accentColor)
                    .clipShape(Circle())
                    .background(Circle())
                    .shadow(color: Color("Shadow"), radius: 15, x: 0, y: 10)
                    .padding(.leading, 20)
            }).padding(.top, UIDevice.current.hasTopNotch ? 3 : 15)
        }
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

struct HomeDriverView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDriverView(showMenu: .constant(false))
    }
}
