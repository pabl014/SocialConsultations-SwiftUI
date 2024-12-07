//
//  CommunityProfile.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 24/11/2024.
//

import Foundation

struct CommunityProfile: Codable {
    let id: Int
    let name: String
    let description: String
    let avatar: FileData?
    let members: [User]
    let administrators: [User]
}
