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
    func didFetchRestaurants(_ restaurants: [Restaurant])
}

class MapViewModel: NSObject {
    weak var delegate: MapViewModelDelegate?

    init(with restaurantProviding: RestaurantProviding, locationManager: CLLocationManager) {
        manager = locationManager
    }
    
    private var userLocation: CLLocation?
    private let manager: CLLocationManager
    
    func requestUserLocation() {
        manager.requestLocation()
    }
}
