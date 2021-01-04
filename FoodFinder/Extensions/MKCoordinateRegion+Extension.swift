//
//  MKCoordinateRegion.swift
//  FoodFinder
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    init(location: CLLocation) {
        let regionRadius: CLLocationDistance = 4500
        self.init(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    }
}
