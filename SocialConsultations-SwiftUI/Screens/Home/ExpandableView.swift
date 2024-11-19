//
//  ExpandableView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 16/11/2024.
//

import SwiftUI
import MapKit

struct ExpandableView: View {
    
    @State private var isExpanded: Bool = false
    
    let lat: Double
    let long: Double
    
    var body: some View {
        VStack {
            Button {
                withAnimation {
                    self.isExpanded.toggle()
                }
           } label: {
                HStack {
                    Text("See on map")
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                }
                .padding()
            }
            
            if isExpanded {
                MapViewForCommunity(latitude: lat, longitude: long)
            }
        }
        .background(.white)
        .itemCornerRadius(10)
        .shadow(radius: 10)
        .padding(.horizontal)
    }
}

#Preview {
    ExpandableView(lat: 52.23072, long: 21.016317)
}


struct MapViewForCommunity: View {
    
    let latitude: Double
    let longitude: Double
    
    @State private var cameraPosition: MapCameraPosition = .automatic //.region(.countryRegion)
    
    var body: some View {
        Map(position: $cameraPosition) {
            Marker(
                "\("Location")",
                coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            )
        }
        .mapControls {
            MapCompass()
            MapPitchToggle()
        }
        .onAppear() {
            cameraPosition = .region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: latitude,
                    longitude: longitude
                ),
                latitudinalMeters: 2000,
                longitudinalMeters: 2000)
            )
        }
        .mapStyle(.hybrid)
        .frame(width: 350, height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding(.bottom)
    }
}
