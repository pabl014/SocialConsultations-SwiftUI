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
    let latitude: Float
    let longitude: Float
    let isPublic: Bool
    let links: [Link]?
}
