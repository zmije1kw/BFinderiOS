import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Favorites") {
                    FavoritesView()
                }
                NavigationLink("Legal") {
                    LegalView()
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(FavoritesManager())
}
