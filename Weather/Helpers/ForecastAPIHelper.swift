//
//  ForecastAPIHelper.swift
//  Weather
//
//  Created by Arjun Shukla on 5/30/22.
//

import Foundation

class ForecastAPIHelper {
    
    private var backgroundQueue = DispatchQueue(label: "com.weather.background", qos: .background, attributes: .concurrent)
    
    private var writerQueue = DispatchQueue(label: "com.threadSafe.writer", attributes: .concurrent)
    
    private var group = DispatchGroup()
    
    func fetchForecastData(completion: @escaping ([Forecast]?) -> Void) {
        var forecasts: [Forecast]? = []
        var urlCacheKey: AnyObject = "" as AnyObject

        for city in CityTestHelper.cityList {
            
            urlCacheKey = API.getForecastUrlString(latitude: city.latitude, longitude: city.longitude) as AnyObject
            
            if let forecastFromCache = Cache.forecastCache.object(forKey: urlCacheKey) {
                forecasts = forecastFromCache as? [Forecast]
                completion(forecasts)
                continue
            }

            group.enter()
            backgroundQueue.async {
                if let url = API.getForecastUrlString(latitude: city.latitude, longitude: city.longitude) {
                    API.getData(url: url) { [weak self] data, response, error in
                        guard let self = self,
                              error == nil else {
                                  self?.group.leave()
                                  return
                              }
                        
                        let decoder = JSONDecoder()
                        if let data = data {
                            do {
                                let forecastResponse = try decoder.decode(ForecastResponseModel.self, from: data)
                                if let forecast = ForecastAPIHelper.createForecastModel(from: forecastResponse, city: city) {
                                    self.writerQueue.async(flags: .barrier) {
                                        forecasts?.append(forecast)
                                    }
                                }
                                self.group.leave()
                            } catch {
                                print(error)
                                self.group.leave()
                            }
                        }
                    }
                } else {
                    self.group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            Cache.forecastCache.setObject(forecasts as AnyObject, forKey: urlCacheKey)
            completion(forecasts)
        }
    }
    
    private static func createForecastModel(from forecastResponse: ForecastResponseModel?, city: City) -> Forecast? {
        let periods: [Period]? = forecastResponse?.properties?.periods
        guard periods != nil,
              !periods!.isEmpty,
              let dayTimeData = periods?.filter({ period in
                  return period.isDaytime ?? false
              }),
              !dayTimeData.isEmpty
               else {
                  return nil
              }
        let tomorrowForecast = dayTimeData.count > 1 ? dayTimeData[city.id] : dayTimeData[0]
        
        let forecast = Forecast(city: city, period: tomorrowForecast)
        return forecast
    }
}
