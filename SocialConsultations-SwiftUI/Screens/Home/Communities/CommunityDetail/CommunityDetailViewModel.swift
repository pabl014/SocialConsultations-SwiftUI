//
//  CommunityDetailViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 13/11/2024.
//

import Foundation

@MainActor
final class CommunityDetailViewModel: ObservableObject {
    
    @Published var community: Community?
    @Published var isLoading = false
    
    func fetchCommunityDetails(id: Int) async {
        isLoading = true
        do {
            community = try await CommunityManager.shared.fetchCommunityDetails(withId: id)
        } catch {
            print("Error loading community details:", error)
        }
        isLoading = false
    }
}
