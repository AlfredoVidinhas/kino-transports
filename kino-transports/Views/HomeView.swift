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
import Combine

struct HomeView: View {
    @Binding var showMenu: Bool
    @AppStorage("log_Status") var status = false
    
    @ObservedObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion.defaultRegion
    @State private var cancellable: AnyCancellable?
    
    @StateObject var mapModel = MapViewModel()
    
    var body: some View {
        VStack{
            ZStack (alignment: .bottom){
                ZStack{
                    MapView(mapModel: mapModel)
                    Image("icon_pin_init").offset(y: -10)
                }
                
                HStack{
                    if mapModel.hasStartPoint {
                        Button(action: {
                            withAnimation{
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()
                                mapModel.removeAllPoints()
                            }
                        }, label: {
                            Image("icon_back")
                                .frame(width: 38, height: 38)
                                .background(Color.accentColor)
                                .clipShape(Circle())
                                .background(Circle())
                                .shadow(color: Color("Shadow"), radius: 15, x: 0, y: 10)
                        })
                    }
                    
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
            
            if mapModel.hasStartPoint {
                HomeDestinationPointView(mapModel: mapModel)
            }
            else {
                HomeStartPointUIView(mapModel: mapModel)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showMenu: .constant(false))
    }
}
