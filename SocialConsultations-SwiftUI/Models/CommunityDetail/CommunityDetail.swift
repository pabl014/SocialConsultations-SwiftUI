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
   // let issues: [Issue]
    var joinRequests: [JoinRequest]
    let latitude: Double
    let longitude: Double
    let isPublic: Bool
}


//struct Community: Codable {
//    let id: Int
//    let name: String
//    let description: String
//    let avatar: FileData?
//    let background: FileData?
//    let administrators: [User]
//    let members: [User]
//    let issues: [Issue]
//    var joinRequests: [JoinRequest]
//    let latitude: Double
//    let longitude: Double
//    let isPublic: Bool
//    let links: [Link]?
//}


//struct CommunityHome: Codable, Equatable {
//    let id: Int
//    let name: String
//    let description: String
//    let avatar: FileData?
//    let members: [User]
//    let latitude: Double
//    let longitude: Double
//    let isPublic: Bool
//    
//    static func == (lhs: CommunityHome, rhs: CommunityHome) -> Bool {
//        return lhs.id == rhs.id
//    }
//}
