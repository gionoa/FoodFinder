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

class MapViewController: UIViewController {
    weak var delegate: MapViewControllerDelegate?

    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.showsUserLocation = true
        return view
    }()

    private lazy var mapViewModel: MapViewModel = {
        let viewModel = MapViewModel()
        viewModel.delegate = self
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        mapViewModel.requestUserLocation()

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

    func shouldSetRegion(_ region: MKCoordinateRegion) {
        mapView.setRegion(region, animated: true)
    }
    func shouldAddAnnotations(_ annotations: [MKPointAnnotation]) {
        mapView.addAnnotations(annotations)
    }
}

extension MapViewController: MKMapViewDelegate { }
