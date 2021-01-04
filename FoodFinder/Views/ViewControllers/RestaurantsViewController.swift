//
//  RestaurantsViewController.swift
//  FoodFinder
//
//  Created by Giovanni Noa on 8/12/20.
//  Copyright © 2020 Giovanni Noa. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController {
    var restaurantsViewModel = RestaurantsViewModel()

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.register(RestaurantTableViewCell.self,
                           forCellReuseIdentifier: RestaurantTableViewCell.reuseIdentifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension RestaurantsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        restaurantsViewModel.restaurantCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? RestaurantTableViewCell else {
            fatalError()
        }

        cell.configure(with: restaurantsViewModel.restaurant(at: indexPath.row))

        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false

        let centerView = UIView()
        centerView.translatesAutoresizingMaskIntoConstraints = false
        centerView.backgroundColor = UIColor(red: 216 / 255, green: 216 / 255, blue: 216 / 255, alpha: 1)
        centerView.layer.cornerRadius = 2.5
        headerView.addSubview(centerView)

        let titleLabel = UILabel()
        titleLabel.text = "Search Results"

        let quantityLabel = UILabel()
        quantityLabel.text = "\(restaurantsViewModel.restaurantCount)"
        quantityLabel.textColor = .white
        quantityLabel.layer.cornerRadius = 0.5 * quantityLabel.frame.width
        quantityLabel.clipsToBounds = false

        #warning("Move colors to app colors enum")
        quantityLabel.backgroundColor = UIColor(red: 2 / 255, green: 104 / 255, blue: 177 / 255, alpha: 1)

        let stackView = UIStackView(arrangedSubviews: [titleLabel, quantityLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8

        headerView.addSubview(stackView)

        let padding: CGFloat = 16
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: padding * 2),
            stackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),

            centerView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: padding),
            centerView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: 207),
            centerView.heightAnchor.constraint(equalToConstant: 5),
            centerView.widthAnchor.constraint(equalToConstant: 64)
        ])

        return headerView
    }
}
