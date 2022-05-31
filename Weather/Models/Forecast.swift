//
//  Forecast.swift
//  Weather
//
//  Created by Arjun Shukla on 5/30/22.
//

import Foundation
/*
 {
 "number": 1,
 "name": "Memorial Day",
 "startTime": "2022-05-30T17:00:00-05:00",
 "endTime": "2022-05-30T18:00:00-05:00",
 "isDaytime": true,
 "temperature": 87,
 "temperatureUnit": "F",
 "temperatureTrend": null,
 "windSpeed": "15 mph",
 "windDirection": "SW",
 "icon": "https://api.weather.gov/icons/land/day/few?size=medium",
 "shortForecast": "Sunny",
 "detailedForecast": "Sunny, with a high near 87. Southwest wind around 15 mph, with gusts as high as 25 mph."
 }
 */
struct Forecast {
    let city: City
    let period: Period
}
