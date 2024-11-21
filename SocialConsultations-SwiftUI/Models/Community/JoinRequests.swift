//
//  JoinRequests.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 07/11/2024.
//

import Foundation

struct JoinRequest: Codable {
    let id: Int
    let user: User?
    let userId: Int
    //let community: Community?
    var status: InviteStatus
    
}

enum InviteStatus: Int, Codable, CaseIterable {
    case pending = 0
    case accepted = 1
    case rejected = 2

    var displayName: String {
        switch self {
        case .pending: return "Pending"
        case .accepted: return "Accepted"
        case .rejected: return "Rejected"
        }
    }
}

