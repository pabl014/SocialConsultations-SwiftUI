//
//  CommunitiesViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/11/2024.
//

import Foundation

@MainActor
final class CommunitiesViewModel: ObservableObject {
    
    @Published var communities: [Community] = []
    @Published var closestCommunities: [Community] = []
    @Published var isLoading = false
    
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
}
