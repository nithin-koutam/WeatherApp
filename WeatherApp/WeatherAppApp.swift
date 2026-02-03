import SwiftUI
import CoreData

@main
struct WeatherAppApp: App {

    let persistence = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              persistence.container.viewContext)
        }
    }
}
