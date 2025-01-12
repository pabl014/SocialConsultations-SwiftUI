//
//  CommunitiesViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/11/2024.
//

import Foundation
import CoreLocation


final class CommunitiesViewModel: NSObject, ObservableObject {
    
    @Published var communities: [CommunityHome] = []
    @Published var closestCommunities: [CommunityHome] = []
    @Published var isLoading = false
    
    private var currentPage: Int = 1
    private var canLoadMorePages: Bool = true
    
    @Published var lastKnownLocation: CLLocationCoordinate2D? {
        didSet {
            if lastKnownLocation != nil {
                Task {
                    await loadClosestCommunities()
                }
            }
        }
    }
    @Published var locationAccessGranted: Bool = false
    
    private let manager = CLLocationManager()
    private var isLocationSet = false // for checking first localization set
    
    @MainActor
    func loadCommunities() async {
        
        guard !isLoading && canLoadMorePages else { return }
        
        isLoading = true
        
        do {
            let communitiesBlock = try await CommunityManager.shared.fetchCommunities(pageNumber: currentPage, pageSize: 10)
            self.communities.append(contentsOf: communitiesBlock)
            canLoadMorePages = !communitiesBlock.isEmpty
            if canLoadMorePages {
                currentPage += 1
            }
        } catch {
            print("Failed to fetch communities:", error)
            canLoadMorePages = false
        }
        isLoading = false
    }
    
    @MainActor
    func refreshCommunities() async {
        currentPage = 1
        canLoadMorePages = true
        self.communities = []
        await loadCommunities()
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
            self.closestCommunities = try await CommunityManager.shared.fetchClosestCommunities(at: location)
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

