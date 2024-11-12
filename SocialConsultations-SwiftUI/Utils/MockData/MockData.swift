//
//  MockData.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/11/2024.
//

import Foundation

struct MockData {
    static let mockCommunity: Community = Community(
        id: 1,
        name: "Sample Community",
        description: "This is a sample community description.",
        avatar: FileData(id: 1, data: Base64examples.example64, description: "Community Avatar", type: 0),
        background: FileData(id: 2, data: Base64examples.example64_3, description: "Community Background", type: 0),
        administrators: [
            User(id: 1, name: "Admin", surname: "User", birthDate: "1985-06-15", email: "admin@example.com", confirmed: true, confirmationCode: nil, avatar: nil)
        ],
        members: [
            User(id: 2, name: "Member", surname: "One", birthDate: "1990-04-20", email: "member1@example.com", confirmed: true, confirmationCode: nil, avatar: FileData(id: 3, data: "base64EncodedStringForAvatar1", description: "Member One Avatar", type: 0)),
            User(id: 3, name: "Member", surname: "Two", birthDate: "1992-07-30", email: "member2@example.com", confirmed: false, confirmationCode: "ABC123", avatar: FileData(id: 4, data: "base64EncodedStringForAvatar2", description: "Member Two Avatar", type: 0))
        ],
        issues: [
            Issue(id: 1),
            Issue(id: 2)
        ],
        joinRequests: [
            JoinRequest(id: 1, user: User(id: 4, name: "Requester", surname: "One", birthDate: "2000-03-10", email: "requester1@example.com", confirmed: false, confirmationCode: "REQ123", avatar: nil), community: Community(id: 1, name: "", description: "", avatar: nil, background: nil, administrators: [], members: [], issues: [], joinRequests: [], latitude: 0.0, longitude: 0.0, isPublic: true, links: []), status: .pending)
        ],
        latitude: 37.7749,
        longitude: -122.4194,
        isPublic: true,
        links: [
            Link(href: "https://example.com", rel: "self", method: "GET")
        ]
    )
    
    static let mockCommunity2: Community = Community(
        id: 2,
        name: "No avatar Community of Jagiellonia",
        description: "This is a sample community description.",
        avatar: nil,
        background: nil,
        administrators: [
            User(id: 1, name: "Admin", surname: "Adminowski", birthDate: "1985-06-15", email: "admin@example.com", confirmed: true, confirmationCode: nil, avatar: nil)
        ],
        members: [
            User(id: 2, name: "Member", surname: "One", birthDate: "1990-04-20", email: "member1@example.com", confirmed: true, confirmationCode: nil, avatar: FileData(id: 3, data: "base64EncodedStringForAvatar1", description: "Member One Avatar", type: 0)),
            User(id: 3, name: "Member", surname: "Two", birthDate: "1992-07-30", email: "member2@example.com", confirmed: false, confirmationCode: "ABC123", avatar: FileData(id: 4, data: "base64EncodedStringForAvatar2", description: "Member Two Avatar", type: 0))
        ],
        issues: [
            Issue(id: 1),
            Issue(id: 2)
        ],
        joinRequests: [
            JoinRequest(id: 1, user: User(id: 4, name: "Requester", surname: "One", birthDate: "2000-03-10", email: "requester1@example.com", confirmed: false, confirmationCode: "REQ123", avatar: nil), community: Community(id: 1, name: "", description: "", avatar: nil, background: nil, administrators: [], members: [], issues: [], joinRequests: [], latitude: 0.0, longitude: 0.0, isPublic: true, links: []), status: .pending)
        ],
        latitude: 37.7749,
        longitude: -122.4194,
        isPublic: false,
        links: [
            Link(href: "https://example.com", rel: "self", method: "GET")
        ]
    )
}
