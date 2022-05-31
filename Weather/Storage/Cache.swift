//
//  Cache.swift
//  Weather
//
//  Created by Arjun Shukla on 5/30/22.
//

import Foundation

class Cache {
    static var imageCache = NSCache<AnyObject, AnyObject>()
    static var forecastCache = NSCache<AnyObject, AnyObject>()
}
