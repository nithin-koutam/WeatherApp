import SwiftUI

struct LandingView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Image(systemName: "umbrella.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    .foregroundColor(.blue)

                Text("Breeze")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Weather App")
                    .foregroundColor(.gray)

                NavigationLink {
                    LocationListView()
                } label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
#Preview {
    LandingView()
}
