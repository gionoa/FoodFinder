//
//  RestaurantsViewModel.swift
//  FoodFinder
//
//  Created by Giovanni Noa on 8/12/20.
//  Copyright © 2020 Giovanni Noa. All rights reserved.
//

import Foundation

class RestaurantsViewModel {
    private var restaurants = [Restaurant]()
    
    var restaurantCount: Int { restaurants.count }

    func setRestaurants(_ restaurants: [Restaurant]) { self.restaurants = restaurants }
    
    func restaurant(at index: Int) -> Restaurant { restaurants[index] }
    
}
