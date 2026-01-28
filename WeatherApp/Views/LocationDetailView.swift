import SwiftUI
import CoreData

struct LocationDetailView: View {

    let location: Location

    @State private var liveTemp: Double?
    @State private var isLoading = false

    private let service = WeatherService(
        networkService: HttpNetworking()
    )

    var body: some View {

        ScrollView {

            VStack(spacing: 25) {

                Text(location.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Image(systemName: location.weather.icon)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.yellow)

                // API Temperature
                if let temp = liveTemp {

                    Text("Live: \(temp, specifier: "%.1f") °C")
                        .font(.title2)
                        .foregroundColor(.green)

                } else if isLoading {

                    ProgressView()
                        .tint(.white)

                } else {

                    Text(location.temperature.temperatureText)
                        .foregroundColor(.gray)
                }

                Text("""
A warm breeze drifted through the streets as the afternoon sun hovered behind a veil of scattered clouds.
""")
                .foregroundColor(.white)
                .padding()

            }
            .padding()
        }
        .background(Color.black)

        // Load API when screen opens
        .task {
            await loadWeather()
        }
    }

    // MARK: - API Call

    private func loadWeather() async {

        isLoading = true

        do {

            let result = try await service.fetchWeather(
                latitude: location.latitude,
                longitude: location.longitude
            )

            liveTemp = result.current.temperature2M
            
            saveWeather(
               city: location.name,
               temp: result.current.temperature2M
            )


        } catch {

            print("API Error:", error)
        }

        isLoading = false
    }
    
    @Environment(\.managedObjectContext)
    private var context

    func saveWeather(city: String, temp: Double) {

        let saved = SavedWeather(context: context)

        saved.city = city
        saved.temp = temp
        saved.date = Date()

        try? context.save()
    }

}

