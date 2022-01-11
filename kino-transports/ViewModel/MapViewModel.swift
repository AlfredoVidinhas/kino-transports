//
//  MapViewModel.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 10/01/22.
//

import SwiftUI
import CoreLocation
import MapKit

class MapViewModel: ObservableObject{
    @Published var centerCoordinate = CLLocation()
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var annotation: MKPointAnnotation?
    @Published var streetName: String = ""
    @Published var isDragMap: Bool = false
}
