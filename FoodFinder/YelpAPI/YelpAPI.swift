//
//  YelpAPI.swift
//  FoodFinder
//
//  Created by Giovanni Noa on 8/12/20.
//  Copyright © 2020 Giovanni Noa. All rights reserved.
//

import Foundation

enum YelpAPI {
    static func fetchRestaurants(latitude: String,
                                longitude: String,
                                completion: @escaping (Result<[Restaurant], YelpAPIError>) -> Void) {
        
        URLSession.shared.dataTask(with: YelpAPI.urlRequest(withPath: .businessesSearch, latitude: latitude, longitude: longitude)) { data, response, error in
            guard let data = data else {
                completion(.failure(.dataObjectError(error.debugDescription)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(YelpData.self, from: data)
                completion(.success(decodedData.businesses))
            } catch (let error) {
                print(error)
                completion(.failure(.decodingError(error.localizedDescription)))
            }
            
        }.resume()
    }
        
    static func urlRequest(withPath path: YelpPaths,
                           latitude: String? = nil,
                           longitude: String? = nil,
                           businessID: String? = nil) -> URLRequest {
        
        var components = URLComponents()
        components.scheme = YelpEndpoint.scheme
        components.host = YelpEndpoint.host
        components.path = path.rawValue
        
        if let latitude = latitude,
            let longitude = longitude {
            components.queryItems = [
                URLQueryItem(name: "latitude", value: latitude),
                URLQueryItem(name: "longitude", value: longitude)]
        }
        
        if let businessID = businessID {
            components.path = components.path + businessID
        }
        
        guard let validURL = components.url else { fatalError("Could not construct URL.") }
    
        var request = URLRequest(url: validURL)
        request.addValue("Bearer \(YelpEndpoint.apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        return request
    }
}

private enum YelpEndpoint {
    static let scheme = "https"
    
    static let host = "api.yelp.com"
    
    // wouldn't typically keep API key public
    static let apiKey = "8lK8Mh7SyZmGO_NAK3TJTq58szFxnzyGV-zxeTRDl0vyvm7ycyzuUFwIeN1FBx_r1lIIdy0ZlGvTzshlW5AfdFQbEU2DaiGk3xg7NR_82QidcdSN_3CXbeyK_PcyX3Yx"
}

private enum YelpQueryItems {
    case term(String?)
    
    case latitude(String?)
    
    case longitude(String?)
    
    case limit(String?)
    
    case offset(String?)
}

enum YelpPaths: String {
    case businessesSearch = "/v3/businesses/search"
    
    case businessSearch = "/v3/businesses/"
}

enum YelpAPIError: Error {
    case dataObjectError(String)
    
    case decodingError(String)
}
