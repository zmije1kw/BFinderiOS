//
//  BottomButtons.swift
//  BFinder
//
//  Created by Kevin Zmijewski on 8/8/25.
//

import SwiftUI
import MapKit
import CoreLocation

extension CLLocationCoordinate2D {
    static let defaultLocation = CLLocationCoordinate2D(
        latitude: 42.3581,
        longitude: -71.0636
    )
}

struct BottomButtons: View {
    
    @Binding var position: MapCameraPosition
    @Binding var searchResults: [MKMapItem]
    
    var visibleRegion: MKCoordinateRegion?

    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = visibleRegion ?? MKCoordinateRegion(
            center: .defaultLocation,
            span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125)
        )
        
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
            print(searchResults)
        }
    }
    
    var body: some View {
        HStack {
            Button {
                search(for: "breakfast")
            } label: {
                Label("Breakfast", systemImage: "fork.knife")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                search(for: "coffee")
            } label: {
                Label("Coffee", systemImage: "cup.and.saucer")
            }
            .buttonStyle(.borderedProminent)

        }
        .labelStyle(.iconOnly)
    }
}

#Preview {
    BottomButtons(position: Binding.constant(.automatic), searchResults: Binding.constant([]))
}
