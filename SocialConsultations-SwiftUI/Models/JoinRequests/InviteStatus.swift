//
//  InviteStatus.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 05/12/2024.
//

import Foundation

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
