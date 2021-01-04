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
    let restaurantProvider: RestaurantProviding
    weak var delegate: MapViewModelDelegate?

    init(with restaurantProviding: RestaurantProviding) {
        restaurantProvider = restaurantProviding
    }
    
    private var userLocation: CLLocation?
    
    private lazy var manager:  CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        return manager
    }()
    
    let regionRadius: CLLocationDistance = 4500
        
    private func createRegion(for location: CLLocation) -> MKCoordinateRegion {
          let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude)
          
          let region = MKCoordinateRegion(center: center,
                                                    latitudinalMeters: regionRadius,
                                                    longitudinalMeters: regionRadius)
          
          return region
      }
    
    func requestUserLocation() {
        manager.requestLocation()
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first { // current user location
            
            let region = createRegion(for: location)
            delegate?.shouldSetRegion(region)
            
   //         delegate?.didUpdateLocations(locations)
            restaurantProvider.fetchRestaurants(latitude: location.coordinate.latitude.description, longitude: location.coordinate.longitude.description) { result in
                
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

