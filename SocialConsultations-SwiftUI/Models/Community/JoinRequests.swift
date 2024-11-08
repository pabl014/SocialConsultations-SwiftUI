//
//  JoinRequests.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 07/11/2024.
//

import Foundation

struct JoinRequest: Codable {
    let id: Int
    let user: User
    let community: Community
    let status: InviteStatus
    
}

enum InviteStatus: Int, Codable {
    case pending = 0
    case accepted = 1
    case rejected = 2
}
