//
//  LocationVM.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 21/08/24.
//

import Foundation
import MapKit

class LocationViewModel: ObservableObject {
    @Published var selectedLocation: CLLocationCoordinate2D? = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)

    func updateLocation(coordinate: CLLocationCoordinate2D) {
        self.selectedLocation = coordinate
    }
}

