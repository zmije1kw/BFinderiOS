//
//  ContentView.swift
//  BFinder
//
//  Created by Kevin Zmijewski on 8/8/25.
//

import UIKit
import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var position: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    
    @State private var searchResults: [MKMapItem] = []
    @State private var selectedResult: MKMapItem?
    
    @State private var route: MKRoute?
    @State private var selectedTransportType: MKDirectionsTransportType = .automobile
    
    @StateObject var locationManager = LocationManager()
    
    @State private var isShowingSheet: Bool = false
    
    var body: some View {
        
        VStack {
            
            HStack {
                Spacer()
                Button {
                    isShowingSheet.toggle()
                } label: {
                    Label("Settings", systemImage: "gear")
                        .foregroundStyle(.gray)
                }
                .sheet(isPresented: $isShowingSheet) {
                  SettingsView()
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.medium, .large])
                }
                .padding(.horizontal)
            }
            .buttonStyle(.borderless)
            .labelStyle(.iconOnly)
            
            Text("BFinder™")
                .font(.largeTitle)
                .fontWeight(.thin)
                .multilineTextAlignment(.center)
            Text("3 Clicks to Breakfast & Coffee")
            
            HStack {
                Button {
                    selectedTransportType = .automobile
                    getDirections()
                } label: {
                    Label("Car", systemImage: "car.fill")
                        .foregroundStyle(selectedTransportType == .automobile ? .blue : .gray)
                }
                Button {
                    selectedTransportType = .walking
                    getDirections()
                } label: {
                    Label("Walk", systemImage: "figure.walk")
                        .foregroundStyle(selectedTransportType == .walking ? .blue : .gray)
                }
            }
            .buttonStyle(.bordered)
            .labelStyle(.iconOnly)
        }
        .onAppear {
            locationManager.requestLocationAuthorization()
            locationManager.startUpdatingLocation()
        }
        .onDisappear {
            locationManager.stopUpdatingLocation()
        }
        
        Map(position: $position, selection: $selectedResult) {
            
            ForEach(searchResults, id: \.self) { result in
                Marker(item: result)
            }
            .annotationTitles(.hidden)
            UserAnnotation()
            
            if let route {
                MapPolyline(route)
                    .stroke(.blue, lineWidth: 5)
            }
            
        }
        .mapStyle(.standard(elevation: .realistic))
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                VStack(spacing:0) {
                    if selectedResult != nil {
                        ItemInfoView(route: $route, selectedResult: $selectedResult)
                            .frame(height: 128)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding([.top, .horizontal])
                    }
                    HStack {
                        BottomButtons(position: $position, searchResults: $searchResults, visibleRegion: visibleRegion)
                            .padding(.top)
                        if selectedResult != nil {
                            Button {
                                if let url = selectedResult?.url {
                                    UIApplication.shared.open(url)
                                }
                            } label: {
                                Label("Website", systemImage: "arrowshape.forward.circle.fill")
                            }
                            .buttonStyle(.borderedProminent)
                            .labelStyle(.iconOnly)
                            .padding(.top)
                        }
                    }
                    
                }
                Spacer()
            }
            .background(.thinMaterial)
        }
        .onChange(of: searchResults) {
            position = .automatic
        }
        .onChange(of: selectedResult) {
            getDirections()
        }
        .onMapCameraChange { context in
            visibleRegion = context.region
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
        
    }
    
    func getDirections() {
        route = nil
        guard let selectedResult else { return }
        
        if let location = locationManager.currentLocation {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon)))
            request.destination = selectedResult
            request.transportType = selectedTransportType
            
            Task {
                let directions = MKDirections(request: request)
                let response = try? await directions.calculate()
                route = response?.routes.first
            }
            
        }
    }

}

#Preview {
    ContentView()
        .environmentObject(FavoritesManager())
}
