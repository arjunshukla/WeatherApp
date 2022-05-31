//
//  API.swift
//  Weather
//
//  Created by Arjun Shukla on 5/30/22.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

class API {
    typealias completion = (Data?, URLResponse?, Error?) -> Void
    
    private static var baseUrl = "https://api.weather.gov"

    static func getForecastUrl(latitude: String, longitude: String) -> URL? {
        URL(string: "\(baseUrl)/gridpoints/TOP/\(latitude),\(longitude)/forecast")
    }

    static func getData(url: URL,
                        completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
}
