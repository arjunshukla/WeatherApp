//
//  UIImageView+Extensions.swift
//  Weather
//
//  Created by Arjun Shukla on 5/30/22.
//

import Foundation
import UIKit

extension UIImageView {
    func loadThumbnial(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        if let imageFromCache = Cache.imageCache.object(forKey: urlString as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        
        ImageAPIHelper.fetchIconImage(url: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let imageToCache = UIImage(data: data) else {
                        self.image = UIImage(named: "placeholder_forecast")
                        return
                    }
                    
                    Cache.imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                    self.image = imageToCache

                case .failure(let error):
                    print(error)
                    self.image = UIImage(named: "placeholder_forecast")
                }
            }
        }
    }
}
