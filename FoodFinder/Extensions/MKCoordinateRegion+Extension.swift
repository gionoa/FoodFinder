//
//  MKCoordinateRegion.swift
//  FoodFinder
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    init(location: CLLocation, withRadius regionRadius: CLLocationDistance) {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                            longitude: location.coordinate.longitude)

        self.init(center: center, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    }
}
