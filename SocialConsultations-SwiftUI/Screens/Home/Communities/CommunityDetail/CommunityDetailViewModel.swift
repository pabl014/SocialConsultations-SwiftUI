//
//  CommunityDetailViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 13/11/2024.
//

import Foundation

@MainActor
final class CommunityDetailViewModel: ObservableObject {
    
    @Published var community: CommunityDetail?
    @Published var isLoading = false
    @Published var user: User?
    @Published var joinRequestStatus: InviteStatus?
    
    @Published var issues: [Issue] = []
    private var currentPage: Int = 1
    private var canLoadMorePages: Bool = true
    @Published var isLoadingIssues = false
    
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
    
    func fetchIssues(for communityID: Int) async {
        
        guard !isLoadingIssues && canLoadMorePages else { return }
        
        isLoadingIssues = true

        do {
            let fetchedIssues = try await IssueManager.shared.fetchIssues(communityID: communityID, pageNumber: currentPage, pageSize: 5)
            
            issues.append(contentsOf: fetchedIssues)
            
            canLoadMorePages = !fetchedIssues.isEmpty
            
            if fetchedIssues.isEmpty {
                canLoadMorePages = false
            } else {
                // Dodaj tylko unikalne elementy
                let newIssues = fetchedIssues.filter { newIssue in
                    !issues.contains(where: { $0.id == newIssue.id })
                }
                issues.append(contentsOf: newIssues)
                currentPage += 1
            }
        } catch {
            print("Failed to fetch issues:", error)
        }
        isLoadingIssues = false
    }
    
    func refreshIssues(for communityID: Int) async {
        
        guard !isLoadingIssues else { return }
        
        currentPage = 1
        canLoadMorePages = true
        issues = []
        
        await fetchIssues(for: communityID)
    }
}
