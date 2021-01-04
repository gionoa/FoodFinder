//
//  Restaurant.swift
//  FoodFinder
//
//  Created by Giovanni Noa on 8/12/20.
//  Copyright © 2020 Giovanni Noa. All rights reserved.
//

import Foundation

struct Restaurant: Codable {
    // swiftlint:disable identifier_name
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
        // swiftlint:disable identifier_name
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
