//
//  ItemInfoView.swift
//  BFinder
//
//  Created by Kevin Zmijewski on 8/8/25.
//

import SwiftUI
import _MapKit_SwiftUI

@available(iOS 17.0, *)
struct ItemInfoView: View {
    
    @State var lookAroundScene: MKLookAroundScene?
    @Binding var route: MKRoute?
    @Binding var selectedResult: MKMapItem?

    func getLookAroundScene () {
        lookAroundScene = nil
        Task {
            if let selectedResult {
                let request = MKLookAroundSceneRequest(mapItem: selectedResult)
                lookAroundScene = try? await request.scene
            }
        }
    }
    
     var travelTime: String? {
        guard let route else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: route.expectedTravelTime)
    }

    var body: some View {
        LookAroundPreview(initialScene: lookAroundScene)
        .overlay(alignment: .bottomTrailing) {
            HStack {
                if let selectedResult {
                    Text ("\(selectedResult.name ?? "")")
                    if let travelTime {
                        Text(travelTime)
                    }
                }
            }
            .font(.caption)
            .foregroundStyle(.white)
            .padding (10)
        }
        .onAppear {
            getLookAroundScene()
        }
        .onChange(of: selectedResult) {
            getLookAroundScene()
        }

    }
    
}

#Preview {
    if #available(iOS 17.0, *) {
        ItemInfoView(route: Binding.constant(nil), selectedResult: Binding.constant(.forCurrentLocation()))
    } else {
        EmptyView()
    }
}
