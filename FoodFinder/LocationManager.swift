////
////  LocationManager.swift
////  FoodFinder
////
////  Created by Giovanni Noa on 8/12/20.
////  Copyright © 2020 Giovanni Noa. All rights reserved.
////
//
// import Foundation
// import MapKit
//
// protocol LocationManagerDelegate: class {
//    func didSetUserLocation()
// }
//
// class LocationManager: NSObject {
//    let manager = CLLocationManager()
//
//    weak var managerDelegate: LocationManagerDelegate?
//
//    var userLocation: CLLocationCoordinate2D? {
//        didSet {
//            managerDelegate?.didSetUserLocation()
//            print(userLocation)
//        }
//    }
//
//     override init() {
//        super.init()
//
//        manager.delegate = self
//        manager.requestWhenInUseAuthorization()
//        manager.requestLocation()
//    }
// }
//
// extension LocationManager: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            userLocation = location.coordinate
//
//
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
// }
