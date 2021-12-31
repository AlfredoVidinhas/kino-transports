//
//  MapView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 31/12/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var currentLocation: CLLocationCoordinate2D?
    var withAnnotation: MKPointAnnotation?
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
            print("Center: \(mapView.centerCoordinate)")
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = false
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let currentLocation = self.currentLocation {
            if let annotation = self.withAnnotation {
                uiView.removeAnnotation(annotation)
            }
            uiView.showsUserLocation = true
            let region = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 500, longitudinalMeters: 500)
            print("location: \(currentLocation)????")
            uiView.setRegion(region, animated: true)
        } else if let annotation = self.withAnnotation {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotation(annotation)
        }
    }
}
