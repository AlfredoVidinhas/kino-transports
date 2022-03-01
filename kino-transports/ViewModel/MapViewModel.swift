//
//  MapViewModel.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 10/01/22.
//

import SwiftUI
import CoreLocation
import MapKit
import Firebase

class MapViewModel: ObservableObject{
    @Published var centerCoordinate = CLLocation()
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var annotations = [MKPointAnnotation]()
    @Published var streetName: String = ""
    @Published var isDragMap = false
    @Published var hasStartPoint = false
    @Published var hasDestinationPoint = false
    @Published var uiMap: MKMapView?
    
    init() {
    }
    
    func createAnnotation(subtitle: String) {
        let annotation = MKPointAnnotation()
        
        annotation.title = streetName
        annotation.subtitle = subtitle
        annotation.coordinate = centerCoordinate.coordinate
        annotations.append(annotation)
        uiMap?.addAnnotations(annotations)
    }
    
    func defineStartPoint() {
        createAnnotation(subtitle: "Ponto de partida")
        hasStartPoint = true
    }
    
    func defineDestinationPoint() {
        createAnnotation(subtitle: "Ponto de Destino")
        hasDestinationPoint = true
    }
    
    func removeAllPoints() {
        print("Passou")
        isDragMap = false
        currentLocation = annotations[0].coordinate
        print("Passou1")
        uiMap?.removeAnnotations(annotations)
        annotations.removeAll()
        hasStartPoint = false
    }
    
    func removeDestinationPoint() {
        
    }
    
    func requestRoute(){
        
    }
    
    func getStartName() -> String {
        return annotations.count > 0 ? annotations[0].title! : "Partida title"
    }
    
    func getDestinationName() -> String {
        return annotations.count > 0 ? annotations[1].title! : "Destino tittle"
    }
    
    func getStarGeoPoint() -> GeoPoint {
        return GeoPoint(latitude: annotations[0].coordinate.latitude, longitude: annotations[0].coordinate.longitude)
    }
    
    func getDestinationGeoPoint() -> GeoPoint {
        return GeoPoint(latitude: annotations[1].coordinate.latitude, longitude: annotations[1].coordinate.longitude)
    }
}
