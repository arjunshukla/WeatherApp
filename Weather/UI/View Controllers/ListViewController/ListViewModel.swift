//
//  ListViewModel.swift
//  Weather
//
//  Created by Arjun Shukla on 5/30/22.
//

import Foundation

protocol ListViewModelDelegate: AnyObject {
    func updateData()
}

class ListViewModel {
    private weak var delegate: ListViewModelDelegate?
    private let apiHelper: ForecastAPIHelper?
    private lazy var forecasts: [Forecast] = []

    init(delegate: ListViewModelDelegate? = nil) {
        self.delegate = delegate
        apiHelper = ForecastAPIHelper()
        getForecasts()
    }
    
    func getForecasts() {
        Cache.forecastCache.removeAllObjects()
        apiHelper?.fetchForecastData(completion: { [weak self] forecasts in
            if let forecasts = forecasts {
                self?.forecasts = forecasts
                self?.delegate?.updateData()
            }
        })
    }
    
    func getNumberOfRows() -> Int {
        forecasts.count
    }
    
    func getCellModel(for index: Int) -> CityTableViewCell.Model? {
        guard !forecasts.isEmpty else { return nil }
        let forecast = forecasts[index]
        
        let temperature = forecast.period.temperature
        let unit = forecast.period.temperatureUnit
        let combinedTemperature = "\(temperature) \(unit.rawValue)"

        let cellModel = CityTableViewCell.Model(cityName: forecast.city.name,
                                                temperature: combinedTemperature, shortForecast: forecast.period.shortForecast, forecaseImageUrl: forecast.period.icon)
        return cellModel
        
    }
}
