//
//  CommunitiesViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/11/2024.
//

import Foundation
import CoreLocation


final class CommunitiesViewModel: NSObject, ObservableObject {
    
    @Published var communities: [Community] = []
    @Published var closestCommunities: [Community] = []
    @Published var isLoading = false
    
    @Published var lastKnownLocation: CLLocationCoordinate2D? {
        didSet {
            if lastKnownLocation != nil {
                Task {
                    await loadClosestCommunities()
                }
            }
        }
    }
    //@Published var lastKnownLocation: CLLocationCoordinate2D?
    @Published var locationAccessGranted: Bool = false
    
    private let manager = CLLocationManager()
    private var isLocationSet = false // for checking first localization set
    
    @MainActor
    func loadCommunities() async {
        isLoading = true
        do {
            self.communities = []
            self.communities = try await CommunityManager.shared.fetchCommunities()
        } catch {
            print("Failed to fetch communities:", error)
        }
        isLoading = false
    }
    
    @MainActor
    func loadClosestCommunities() async {
        
        guard let location = lastKnownLocation else { return }
        print(location.latitude)
        print(location.longitude)
        isLoading = true
        isLocationSet = false
        initializeLocationServices()
        do {
            self.closestCommunities = []
            self.closestCommunities = try await CommunityManager.shared.fetchCommunities()
            //self.closestCommunities = try await CommunityManager.shared.fetchClosestCommunities(at: location)
        } catch {
            print("Failed to fetch closest communities:", error)
        }
        isLoading = false
    }
    
    public func initializeLocationServices() {
        setupLocationManager()
    }
}

extension CommunitiesViewModel: CLLocationManagerDelegate {
    
    private func setupLocationManager() {
        manager.delegate = self
        if !isLocationSet {
            manager.startUpdatingLocation()
        }
       
    }
    
    private func checkLocationAuthorization() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            
        case .restricted, .denied:
            locationAccessGranted = false
            print("Location restricted or denied")
            
        case .authorizedAlways, .authorizedWhenInUse:
            locationAccessGranted = true
            lastKnownLocation = manager.location?.coordinate
            
        @unknown default:
            print("Location service disabled")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        guard let location = locations.first else { return }
//        
//        let latitude = location.coordinate.latitude
//        let longitude = location.coordinate.longitude
//        
//        lastKnownLocation = location.coordinate
//        
//        isLocationSet = true
//        manager.stopUpdatingLocation()
//        
//        print("Latitude: \(latitude), Longitude: \(longitude)")
        
        guard let location = locations.first else { return }
        
        // Sprawdź, czy różnica jest znacząca (np. > 900 metrów)
        if let previousLocation = lastKnownLocation {
            let distance = location.distance(from: CLLocation(latitude: previousLocation.latitude, longitude: previousLocation.longitude))
            if distance < 900 { return } // Jeśli odległość jest mniejsza niż 900 metrów, ignorujemy aktualizację
        }
        
        lastKnownLocation = location.coordinate
        print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
    }
}
