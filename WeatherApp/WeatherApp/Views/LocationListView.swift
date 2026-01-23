import SwiftUI

struct LocationListView: View {
    var body: some View {
        List(locations) { location in
            NavigationLink {
                LocationDetailView(location: location)
            } label: {
                HStack {
                    Text(location.name)
                    Spacer()
                    Image(systemName: location.weather.icon)
                        .foregroundColor(.yellow)
                }
            }
        }
        .navigationTitle("Locations")
    }
}

#Preview {
    LocationListView()
}
