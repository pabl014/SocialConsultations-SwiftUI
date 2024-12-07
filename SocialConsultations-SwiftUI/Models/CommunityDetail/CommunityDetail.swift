//
//  CommunityDetail.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 22/11/2024.
//

import Foundation

struct CommunityDetail: Codable {
    let id: Int
    let name: String
    let description: String
    let background: FileData?
    let administrators: [User]
    let members: [User]
    var joinRequests: [JoinRequest]
    let latitude: Double
    let longitude: Double
}
