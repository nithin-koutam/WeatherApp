import Foundation

// Request

struct WeatherRequest {
    let latitude: Double
    let longitude: Double
}

// Endpoint

struct WeatherEndpoint: APIEndpoint {

    let request: WeatherRequest

    var baseURL: String {
        "https://api.open-meteo.com"
    }

    var path: String {
        "/v1/forecast"
    }

    var queryItems: [URLQueryItem] {

        [
            URLQueryItem(name: "latitude", value: "\(request.latitude)"),
            URLQueryItem(name: "longitude", value: "\(request.longitude)"),
            URLQueryItem(name: "current", value: "temperature_2m")
        ]
    }
}

// Response

struct WeatherResponse: Codable {

    let latitude: Double
    let longitude: Double
    let generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone: String
    let timezoneAbbreviation: String
    let elevation: Int
    let currentUnits: CurrentUnits
    let current: Current

    enum CodingKeys: String, CodingKey {

        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentUnits = "current_units"
        case current
    }
}

// Current

struct Current: Codable {

    let time: String
    let interval: Int
    let temperature2M: Double

    enum CodingKeys: String, CodingKey {

        case time, interval
        case temperature2M = "temperature_2m"
    }
}

// Units

struct CurrentUnits: Codable {

    let time: String
    let interval: String
    let temperature2M: String

    enum CodingKeys: String, CodingKey {

        case time, interval
        case temperature2M = "temperature_2m"
    }
}
