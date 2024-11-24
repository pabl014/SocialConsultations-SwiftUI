//
//  ProfileViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 04/11/2024.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published var user: User? {
        didSet {
            Task {
                await fetchCommunitiesForUser()
            }
        }
    }
    
    @Published var errorMessage: ErrorMessage?
    @Published var communitiesMember: [CommunityProfile] = []
    @Published var communitiesAdmin: [CommunityProfile] = []
    
    func fetchCurrentUser() async {
        do {
            self.user = try await UserManager.shared.fetchCurrentUser()
        } catch {
            errorMessage = ErrorMessage(message: error.localizedDescription)
        }
    }
    
    func fetchUser(with id: Int) async {
        do {
            self.user = try await UserManager.shared.fetchUserData(userId: id)
        } catch {
            errorMessage = ErrorMessage(message: error.localizedDescription)
        }
    }
    
    func fetchCommunitiesForUser() async {
        
        guard let currentUserId = user?.id else {
            return
        }
        
        do {
            let communities = try await CommunityManager.shared.fetchCommunities()
            
            communitiesMember = communities.filter { community in
                community.members.contains { $0.id == currentUserId }
            }
            
            communitiesAdmin = communities.filter { community in
                community.administrators.contains { $0.id == currentUserId }
            }
            
        } catch {
            errorMessage = ErrorMessage(message: error.localizedDescription)
            print("Error: \(error.localizedDescription)")
        }
    }
    
}
