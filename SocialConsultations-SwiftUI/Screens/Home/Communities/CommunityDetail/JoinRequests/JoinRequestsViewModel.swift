//
//  JoinRequestsViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 19/11/2024.
//

import Foundation

@MainActor
final class JoinRequestsViewModel: ObservableObject {
    
    @Published var joinRequests: [JoinRequest] = []
    @Published var communityID: Int = -1
    
    func setup(_ joinRequests: [JoinRequest], _ communityID: Int) {
        self.joinRequests = joinRequests
        self.communityID = communityID
    }
    
    func filteredRequests(for status: InviteStatus?) -> [JoinRequest] {
        if let status {
            return joinRequests.filter { $0.status == status }
        }
        return joinRequests
    }
    
    func acceptRequest(_ requestID: Int) async {
        
        do {
            try await CommunityManager.shared.updateJoinRequestStatus(communityId: communityID, joinRequestId: requestID, status: .accepted)
            
            if let index = joinRequests.firstIndex(where: { $0.id == requestID }) {
                joinRequests[index].status = .accepted
            }
            
        } catch {
            print("failed to accept request")
            print(error.localizedDescription)
        }
    }
    
    func rejectRequest(_ requestID: Int) async {
        do {
            try await CommunityManager.shared.updateJoinRequestStatus(communityId: communityID, joinRequestId: requestID, status: .rejected)
            
            if let index = joinRequests.firstIndex(where: { $0.id == requestID }) {
                joinRequests[index].status = .rejected
            }
        } catch {
            print("failed to reject request")
            print(error.localizedDescription)
        }
    }
}
