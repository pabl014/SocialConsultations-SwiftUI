//
//  MembersViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 01/12/2024.
//

import Foundation

@MainActor
final class MembersViewModel: ObservableObject {
    
    @Published var members: [User] = []
    @Published var isLoading = false
    
    func fetchMembers(for communityId: Int) async {
        isLoading = true
        do {
            let fetchedMembers = try await CommunityManager.shared.getMembers(communityId: communityId)
            self.members = fetchedMembers
        } catch {
            print("Error in fetching members: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    
    func deleteMember(_ member: User, communityId: Int) async {
        do {
            try await CommunityManager.shared.removeMember(communityId: communityId, userId: member.id)
            print("Member removed successfully")
            members.removeAll(where: { $0.id == member.id })
        } catch {
            print("Error in deleting member: \(error.localizedDescription)")
        }
    }
}
