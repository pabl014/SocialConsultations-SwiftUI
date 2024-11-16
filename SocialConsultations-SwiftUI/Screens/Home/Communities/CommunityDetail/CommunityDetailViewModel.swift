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
    @Published var user: User?
    @Published var joinRequestStatus: InviteStatus?
    
    func fetchCommunityDetails(id: Int) async {
        isLoading = true
        do {
            community = try await CommunityManager.shared.fetchCommunityDetails(withId: id)
        } catch {
            print("Error loading community details:", error)
        }
        isLoading = false
    }
    
    func fetchCurrentUser() async {
        do {
            self.user = try await UserManager.shared.fetchCurrentUser()
            print(user?.name ?? "no name")
        } catch {
            print("Failed to fetch user")
        }
    }
    
    func sendJoinRequest() async {
        
        guard let community else {
            print("Brak danych społeczności.")
            return
        }
        
        do {
            try await CommunityManager.shared.sendJoinRequest(toCommunity: community.id)
            joinRequestStatus = .pending
            print("Wysłano JoinRequest dla społeczności: \(community.name)")
            await fetchCommunityDetails(id: community.id)
        } catch {
            print("Błąd podczas wysyłania JoinRequest:", error.localizedDescription)
        }
    }
    
    func isAdmin() -> Bool {
        guard let currentUser = user, let community = community else {
            return false
        }
        return community.administrators.contains { $0.id == currentUser.id }
    }
    
    func isMember() -> Bool {
        guard let currentUser = user, let community = community else {
            return false
        }
        return community.members.contains { $0.id == currentUser.id }
    }
    
    func hasPendingJoinRequest() -> Bool {
        guard let currentUser = user, let community = community else {
            return false
        }
        return community.joinRequests.contains { joinRequest in
            // Porównujemy userId z currentUser.id
            return joinRequest.userId == currentUser.id && joinRequest.status == .pending
        }
    }
    
    func canJoinCommunity() -> Bool {
        return !isAdmin() && !isMember() && !hasPendingJoinRequest()
    }
}
