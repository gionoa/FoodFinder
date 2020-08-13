//
//  Restaurant.swift
//  FoodFinder
//
//  Created by Giovanni Noa on 8/12/20.
//  Copyright © 2020 Giovanni Noa. All rights reserved.
//

import Foundation

// wanted to make Business and Restaurant the same struct by using optionals but coordinates and location properties are flipped in each model, so I didn't know how to approach that. 
struct YelpData: Codable {
    let businesses: [Restaurant]
}

struct Restaurant: Codable {
    let id: String
    let name: String
    let isClosed: Bool
    let rating: Double
    let coordinates: Coordinates
    let location: Location
    let phone: String
    let displayPhone: String
    let distance: Double

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isClosed = "is_closed"
        case rating
        case coordinates
        case location
        case phone
        case displayPhone = "display_phone"
        case distance
    }
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

struct Location: Codable {
    let displayAddress: [String]

    enum CodingKeys: String, CodingKey {
        case displayAddress = "display_address"
    }
}
