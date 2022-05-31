//
//  ForecastResponseModel.swift
//  Weather
//
//  Created by Arjun Shukla on 5/30/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(ForecastResponseModel.self, from: jsonData)

import Foundation

// MARK: - ForecastResponseModel
struct ForecastResponseModel: Codable {
    let context: [ContextElement]?
    let type: String?
    let geometry: Geometry?
    let properties: Properties?

    enum CodingKeys: String, CodingKey {
        case context = "@context"
        case type, geometry, properties
    }
}

enum ContextElement: Codable {
    case contextClass(ContextClass)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(ContextClass.self) {
            self = .contextClass(x)
            return
        }
        throw DecodingError.typeMismatch(ContextElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ContextElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .contextClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ContextClass
struct ContextClass: Codable {
    let version: String?
    let wx: String?
    let geo, unit: String?
    let vocab: String?

    enum CodingKeys: String, CodingKey {
        case version = "@version"
        case wx, geo, unit
        case vocab = "@vocab"
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: String?
    let coordinates: [[[Double]]]?
}

// MARK: - Properties
struct Properties: Codable {
//    let updated: Date?
    let units, forecastGenerator: String?
//    let generatedAt, updateTime: Date?
    let validTimes: String?
    let elevation: Elevation?
    let periods: [Period]?
}

// MARK: - Elevation
struct Elevation: Codable {
    let unitCode: String?
    let value: Double?
}

// MARK: - Period
struct Period: Codable {
    let number: Int?
    let name: String?
//    let startTime, endTime: Date?
    let isDaytime: Bool?
    let temperature: Int
    let temperatureUnit: TemperatureUnit
    let temperatureTrend: JSONNull?
    let windSpeed, windDirection: String?
    let icon: String?
    let shortForecast, detailedForecast: String?
}

enum TemperatureUnit: String, Codable {
    case f = "F"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
