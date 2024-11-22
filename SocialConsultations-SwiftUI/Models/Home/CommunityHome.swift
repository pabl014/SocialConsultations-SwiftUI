//
//  CommunityHome.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 21/11/2024.
//

import Foundation

struct CommunityHome: Codable, Equatable {
    let id: Int
    let name: String
    let description: String
    let avatar: FileData?
    let members: [User]
    let latitude: Double
    let longitude: Double
    let isPublic: Bool
    
    static func == (lhs: CommunityHome, rhs: CommunityHome) -> Bool {
        return lhs.id == rhs.id
    }
}
