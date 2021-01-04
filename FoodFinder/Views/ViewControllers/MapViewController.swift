//
//  MapViewController.swift
//  FoodFinder
//
//  Created by Giovanni Noa on 8/12/20.
//  Copyright © 2020 Giovanni Noa. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewControllerDelegate: class {
    func didFetchRestaurants(_ restaurants: [Restaurant])
}

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    let regionRadius: CLLocationDistance = 4500

    let mapView: MKMapView

    init(mapView: MKMapView) {
        self.mapView = mapView
    }

    private func createRegion(for location: CLLocation) -> MKCoordinateRegion {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                            longitude: location.coordinate.longitude)

        let region = MKCoordinateRegion(center: center,
                                        latitudinalMeters: regionRadius,
                                        longitudinalMeters: regionRadius)

        return region
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first { // current user location
            let region = createRegion(for: location)
            mapView.setRegion(region, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed with error: \(error)")
    }
}

class MapViewController: UIViewController {
    weak var delegate: MapViewControllerDelegate?
    let restaurantProvider: RestaurantProviding

    private let mapView: MKMapView
    private var locationManagerDelegate: LocationManagerDelegate

    init(with restaurantProviding: RestaurantProviding) {
        let mapView = MKMapView()
        restaurantProvider = restaurantProviding
        locationManagerDelegate = LocationManagerDelegate(mapView: mapView)
        self.mapView = mapView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var manager:  CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = locationManagerDelegate
        return manager
    }()

    private lazy var mapViewModel: MapViewModel = {
        let viewModel = MapViewModel(with: YelpAPI(), locationManager: manager)
        viewModel.delegate = self
        return viewModel
    }()
     
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        mapView.showsUserLocation = true

        mapViewModel.requestUserLocation()
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension MapViewController: MapViewModelDelegate {
    func didFetchRestaurants(_ restaurants: [Restaurant]) {
        delegate?.didFetchRestaurants(restaurants)
    }

}

extension MapViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        let coordinate = mapView.userLocation.coordinate
        restaurantProvider.fetchRestaurants(latitude: coordinate.latitude.description, longitude: coordinate.longitude.description) { result in

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

                mapView.addAnnotations(annotations)
            case .failure(let error):
                print(error)
            }
        }
    }
}
