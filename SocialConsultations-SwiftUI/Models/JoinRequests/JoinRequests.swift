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
    var status: InviteStatus
    
}


