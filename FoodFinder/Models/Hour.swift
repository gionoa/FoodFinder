//
//  Hour.swift
//  FoodFinder
//

import Foundation

struct Hour: Codable {
    let isOpenNow: Bool

    enum CodingKeys: String, CodingKey {
        case isOpenNow = "is_open_now"
    }
}
