//
//  MapView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 31/12/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var centerCoordinate: CLLocation
    @Binding var currentLocation: CLLocationCoordinate2D?
    @Binding var streetName: String
    var withAnnotation: MKPointAnnotation?
    let regionInMeters: Double = 10000
    var previousLocation: CLLocation?
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            //print("Center: \(mapView.centerCoordinate)")
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            let center = getCenterLocation(for: mapView)
            let geoCoder = CLGeocoder()
            
            if parent.previousLocation == nil {
                parent.previousLocation = center
            }
            
            guard let previousLocation = parent.previousLocation else { return }
            
            guard center.distance(from: previousLocation) > 50 else { return }
            parent.previousLocation = center
            
            geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
                guard self != nil else { return }
                
                if let _ = error {
                    //TODO: Show alert informing the user
                    print("Errorrrrr")
                    return
                }
                
                guard let placemark = placemarks?.first else {
                    //TODO: Show alert informing the user
                    return
                }
                
                //let streetNumber = placemark.subThoroughfare ?? ""
                let streetName = placemark.thoroughfare ?? ""
                let streetCity = placemark.name ?? ""
                
                DispatchQueue.main.async {
                    mapView.showsUserLocation = false
                    self!.parent.streetName = "\(streetName)"
                    print("\(streetCity) \(streetName)")
                }
            }
        }
        
        func getCenterLocation(for mapView: MKMapView) -> CLLocation {
            let latitude = mapView.centerCoordinate.latitude
            let longitude = mapView.centerCoordinate.longitude
            
            return CLLocation(latitude: latitude, longitude: longitude)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let currentLocation = self.currentLocation {
            if let annotation = self.withAnnotation {
                uiView.removeAnnotation(annotation)
            }
            if uiView.showsUserLocation {
                let region = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 500, longitudinalMeters: 500)
                print("location1: \(currentLocation)????")
                uiView.setRegion(region, animated: true)
            }
            else{
                uiView.showsUserLocation = true
            }
        } else if let annotation = self.withAnnotation {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotation(annotation)
        }
    }
}
