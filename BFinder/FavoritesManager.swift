import Foundation
import MapKit

struct FavoriteLocation: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let latitude: Double
    let longitude: Double

    init(mapItem: MKMapItem) {
        self.id = UUID()
        self.name = mapItem.name ?? "Unknown"
        self.latitude = mapItem.placemark.coordinate.latitude
        self.longitude = mapItem.placemark.coordinate.longitude
    }
}

class FavoritesManager: ObservableObject {
    @Published private(set) var favorites: [FavoriteLocation] = []
    private let defaultsKey = "favorites"

    init() {
        load()
    }

    func isFavorite(_ mapItem: MKMapItem) -> Bool {
        favorites.contains(where: { $0.name == mapItem.name &&
            $0.latitude == mapItem.placemark.coordinate.latitude &&
            $0.longitude == mapItem.placemark.coordinate.longitude })
    }

    func toggle(mapItem: MKMapItem) {
        if let index = favorites.firstIndex(where: { $0.name == mapItem.name &&
            $0.latitude == mapItem.placemark.coordinate.latitude &&
            $0.longitude == mapItem.placemark.coordinate.longitude }) {
            favorites.remove(at: index)
        } else {
            favorites.append(FavoriteLocation(mapItem: mapItem))
        }
        save()
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: defaultsKey),
           let decoded = try? JSONDecoder().decode([FavoriteLocation].self, from: data) {
            favorites = decoded
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: defaultsKey)
        }
    }
}
