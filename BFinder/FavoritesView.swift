import SwiftUI
import MapKit

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        List {
            if favoritesManager.favorites.isEmpty {
                Text("No favorites yet.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(favoritesManager.favorites) { favorite in
                    VStack(alignment: .leading) {
                        Text(favorite.name)
                        Text("\(favorite.latitude), \(favorite.longitude)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Favorites")
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesManager())
}
