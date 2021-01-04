//
//  MapViewModel.swift
//  FoodFinder
//
//  Created by Giovanni Noa on 8/12/20.
//  Copyright © 2020 Giovanni Noa. All rights reserved.
//

import Foundation
import MapKit

protocol MapViewModelDelegate: class {
    func shouldSetRegion(_ region: MKCoordinateRegion)
    func shouldAddAnnotations(_ annotations: [MKPointAnnotation])
    func didFetchRestaurants(_ restaurants: [Restaurant])
}

class MapViewModel: NSObject {
    weak var delegate: MapViewModelDelegate?

    private var userLocation: CLLocation?

    private lazy var manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        return manager
    }()

    let regionRadius: CLLocationDistance = 4500

    func requestUserLocation() {
        manager.requestLocation()
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first { // current user location

            let region = MKCoordinateRegion(location: location, withRadius: regionRadius)

            delegate?.shouldSetRegion(region)

            YelpAPI.fetchRestaurants(at: location) { result in

                switch result {
                case .success(let restaurants):
                    self.delegate?.didFetchRestaurants(restaurants)

                    let annotations = restaurants.map { restaurant -> MKPointAnnotation in
                        let coordinate = CLLocationCoordinate2D(latitude: restaurant.coordinates.latitude,
                                                                longitude: restaurant.coordinates.longitude)

                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinate
                        annotation.title = restaurant.name

                        return annotation
                    }

                    self.delegate?.shouldAddAnnotations(annotations)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed with error: \(error)")
    }
}
