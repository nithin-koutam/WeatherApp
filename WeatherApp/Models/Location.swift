import SwiftUI

struct Temperature {
    let min: Int
    let max: Int

    var temperatureText: String {
        "\(min) °C / \(max) °C"
    }
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let weather: Weather
    let temperature: Temperature
    let latitude: Double
    let longitude: Double
}



