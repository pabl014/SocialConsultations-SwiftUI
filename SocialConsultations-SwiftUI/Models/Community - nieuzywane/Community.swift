//
//  Community.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 07/11/2024.
//

import Foundation

struct Community: Codable {
    let id: Int
    let name: String
    let description: String
    let avatar: FileData?
    let background: FileData?
    let administrators: [User]
    let members: [User]
    let issues: [Issue]
    var joinRequests: [JoinRequest]
    let latitude: Double
    let longitude: Double
    let isPublic: Bool
    let links: [Link]?
}

