//
//  MapView.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 31/12/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    let regionInMeters: Double = 10000
    var previousLocation: CLLocation?
    
    @StateObject var mapModel = MapViewModel()
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            
            let identifier = "Placemark"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            //if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.image = UIImage(named: parent.mapModel.annotations.count > 1 ? "icon_pin_end.png" : "icon_pin_start.png")
                print("number: \(parent.mapModel.annotations.count)")
                annotationView?.frame.size = CGSize(width: 24, height: 24)
                annotationView?.centerOffset = CGPoint(x: 0, y:-10/2);
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            //}
            /*else {
                annotationView?.annotation = annotation
                print("ele !!!!!")
            }*/
            
            return annotationView
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
            parent.mapModel.centerCoordinate = center
            
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
                    self!.parent.mapModel.isDragMap = true
                    self!.parent.mapModel.streetName = "\(streetName)"
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
        mapView.showsUserLocation = false
        mapModel.uiMap = mapView
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let currentLocation = self.mapModel.currentLocation {
            if self.mapModel.isDragMap == false {
                uiView.showsUserLocation = true
                let region = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 800, longitudinalMeters: 800)
                print("location1: \(currentLocation)????")
                uiView.setRegion(region, animated: true)
            }
        }
    }
}
