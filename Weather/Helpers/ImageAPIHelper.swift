//
//  ImageAPIHelper.swift
//  Weather
//
//  Created by Arjun Shukla on 5/30/22.
//

import Foundation
class ImageAPIHelper {
    static func fetchIconImage(url: URL,
                               completion: @escaping (Result<Data>) -> Void) {
        API.getData(url: url, completion: { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            completion(.success(data))
        })
    }
}
