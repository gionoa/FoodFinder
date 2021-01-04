//
//  Restaurant.swift
//  FoodFinder
//
//  Created by Giovanni Noa on 8/12/20.
//  Copyright © 2020 Giovanni Noa. All rights reserved.
//

import Foundation

// MARK: - Hour
struct RestaurantInfo: Codable {
    let id: String
    let name: String
    let isClosed: Bool
    let phone: String?
    let displayPhone: String
    let rating: Int
    let location: Location
    let coordinates: Coordinates
    let photos: [String]
    let hours: [Hour]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isClosed = "is_closed"
        case phone
        case displayPhone = "display_phone"
        case rating
        case location
        case coordinates
        case photos
        case hours
    }
}
