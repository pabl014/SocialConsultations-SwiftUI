//
//  ConsultationDetailView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 11/10/2024.
//

import SwiftUI
import MapKit

struct ConsultationDetailView: View {
    
    @State private var isSheetPresented = false
    
    var body: some View {
        ScrollView(.vertical) {
            firstSection
                .background(Color(UIColor.secondarySystemBackground))
                .itemCornerRadius(20)
                .shadow(radius: 5)
                .padding()
            
            infoSection
                .background(Color(UIColor.secondarySystemBackground))
                .itemCornerRadius(20)
                .shadow(radius: 5)
                .padding()
            
            Button {
                isSheetPresented.toggle()
            } label: {
                Text("See discussion")
                    .defaultButtonStyle()
                    .padding()
            }
            .background(Color(UIColor.secondarySystemBackground))
            .itemCornerRadius(20)
            .shadow(radius: 5)
            .padding()
            .sheet(isPresented: $isSheetPresented) {
                DiscussionView()
                    .presentationDetents([.medium, .large])
            }

        }
        //.background(LinearGradient(colors: [.blue, .blue, .cyan, .white, .white], startPoint: .bottomLeading, endPoint: .topTrailing))
        .background(GradientTest().ignoresSafeArea(.all))
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)

    }
    
    var firstSection: some View {
        
        VStack(alignment: .leading) {
            // Image Section
            TabView {
                ForEach(0..<3) { index in
                    ImageBase64View(base64String: Constants.example64) // Przykładowy obraz
                        .frame(height: 250)
                        .clipped()
                        .itemCornerRadius(20)
                }
            }
            .frame(height: 250)
            .tabViewStyle(PageTabViewStyle()) // Styl stron dla przewijania
//            ImageBase64View(base64String: Constants.example64)
//                .frame(height: 250)
//                .clipped()
//                .itemCornerRadius(20)
            
            
            // Content Section
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 16) {
                    Text("CATEGORY")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                    Text("Private")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
                
                Text("Social Consultations about healthcare in Poland")
                    .font(.title3)
                    .bold()
                    .lineLimit(2)
                
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                    
                    Text("Javi Garcia")
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                    .font(.body)
                    .foregroundColor(.primary)
                    
            }
            .padding()
        }
    }
    
    var infoSection: some View {
            VStack(alignment: .leading, spacing: 10) {
                Text("Information")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                
                VStack(alignment: .leading) {
                    Text("Date: ") + Text("27 May 2024")
                        .fontWeight(.bold)
                        .font(.callout)
                        .foregroundColor(.primary)
                    
                    Text("Location: ") + Text("ul. Sztabkowa 12")
                        .fontWeight(.bold)
                        .font(.callout)
                        .foregroundColor(.primary)
                    
                    Text("Start: ") + Text("18:30")
                        .fontWeight(.bold)
                        .font(.callout)
                        .foregroundColor(.primary)
                }
                
                MapView()
                    .frame(height: 250)
                    .itemCornerRadius(10)
                    .clipped()
            }
            .padding()
        }
}


struct MapView: View {
    
    let consultation: Consultation = Consultation(latlng: [53.11702, 23.07960])
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        Map(position: $cameraPosition) {
            Marker(
                "\("Location")",
                coordinate: CLLocationCoordinate2D(latitude: consultation.latlng[0], longitude: consultation.latlng[1])
            )
        }
        .mapControls {
            MapCompass()
            MapPitchToggle()
        }
        .onAppear() {
            cameraPosition = .region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: consultation.latlng[0],
                    longitude: consultation.latlng[1]
                ),
                latitudinalMeters: 100,
                longitudinalMeters: 100)
            )
        }
        .mapStyle(.hybrid)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    NavigationStack {
        ConsultationDetailView()
    }
}

struct Consultation {
    let latlng: [Double]
}
