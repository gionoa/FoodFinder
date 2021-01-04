//
//  Location.swift
//  FoodFinder
//

import Foundation

struct Location: Codable {
    let displayAddress: [String]

    enum CodingKeys: String, CodingKey {
        case displayAddress = "display_address"
    }
}
