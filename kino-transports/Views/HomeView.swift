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
    
    var body: some View {
        VStack{
            ZStack (alignment: .bottom){
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil)
                    .onChange(of: region.center.latitude) { newRegion in
                        // the region changed to newRegion
                        print("lat: \(region.center.latitude)")
                    }
                //MapView(region: $region)
                
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
                            .resizable()
                            .frame(width: 25, height: 25)
                            .background(Color.accentColor)
                            .clipShape(Circle())
                            .background(Circle().frame(width: 38, height: 38))
                            .shadow(color: Color("Shadow"), radius: 15, x: 0, y: 10)
                    })
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
            }
            
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
            region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 500, longitudinalMeters: 500)
        }
    }
}

struct MapView: UIViewRepresentable {
    
    @Binding var region: MKCoordinateRegion
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        //map.mapType = .standard
        map.showsUserLocation = false
        map.isRotateEnabled = false

        map.setRegion(region, animated: true)
        
        print("Lat: \(map.centerCoordinate.latitude)")

        /*let annotation = MyAnnotation(coordinate: location.coordinate)
        annotation.title = "Title"
        annotation.subtitle = "Subtitle"
        map.addAnnotation(annotation)*/

        return map
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.showsUserLocation = true
        uiView.setRegion(region, animated: true)
        print("Lat: \(uiView.centerCoordinate.latitude)")
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("Lat: \(mapView.centerCoordinate.latitude)")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showMenu: .constant(false))
    }
}
