//
//  MainViewController.swift
//  FoodFinder
//
//  Created by Giovanni Noa on 8/12/20.
//  Copyright © 2020 Giovanni Noa. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    let mapVC = MapViewController()

    let restaurantsVC = RestaurantsViewController()

    override func viewDidLoad() {
        addMapVC()
        addRestaurantsVC()
    }

    private func addMapVC() {
        mapVC.delegate = self
        mapVC.view.translatesAutoresizingMaskIntoConstraints = false
        mapVC.view.backgroundColor = .white
        addChild(mapVC)
        view.addSubview(mapVC.view)
        NSLayoutConstraint.activate([
            mapVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            mapVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapVC.view.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 323)
        ])
    }

    private func addRestaurantsVC() {
        restaurantsVC.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(restaurantsVC)
        view.addSubview(restaurantsVC.view)
        NSLayoutConstraint.activate([
            restaurantsVC.view.topAnchor.constraint(equalTo: mapVC.view.bottomAnchor),
            restaurantsVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            restaurantsVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            restaurantsVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainViewController: MapViewControllerDelegate {
    func didFetchRestaurants(_ restaurants: [Restaurant]) {
        restaurantsVC.restaurantsViewModel.setRestaurants(restaurants)

        // given more time, I'd refactor this
        DispatchQueue.main.async { self.restaurantsVC.tableView.reloadSections(IndexSet([0]), with: .automatic) }
    }
}
