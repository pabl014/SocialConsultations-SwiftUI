//
//  MockData.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/11/2024.
//

import Foundation

struct MockData {
    
    
    //MARK: - Mock FileData
    
    static let mockImage1 = FileData(
        id: 1234,
        data: Base64examples.example64_3,
        description: "User avatar 1",
        type: 0
    )
    
    static let mockImage2 = FileData(
        id: 5678,
        data: Base64examples.example64,
        description: "User avatar 2",
        type: 0
    )
    
    static let mockImage3 = FileData(
        id: 9012,
        data: Base64examples.example64_2,
        description: "User avatar 3",
        type: 0
    )
    
    //MARK: - Mock Users
    
    static let mockUser1 = User(
        id: 101,
        name: "Jose",
        surname: "Mourinho",
        birthDate: "1963-03-04",
        email: "josemourinho@jkhabhdyg.com",
        confirmed: true,
        confirmationCode: "eaaisjgi12",
        avatar: mockImage1
    )
    
    static let mockUser2 = User(
        id: 178,
        name: "Didier",
        surname: "Drogba",
        birthDate: "1980-07-08",
        email: "drogba@ijgjg.com",
        confirmed: true,
        confirmationCode: "jjrgjrgrg",
        avatar: mockImage2
    )
    
    static let mockUser3 = User(
        id: 994,
        name: "Tomasz",
        surname: "Frankowski",
        birthDate: "1972-09-02",
        email: "franek123@lgkrkgr.com",
        confirmed: true,
        confirmationCode: "pzpolejk246",
        avatar: mockImage3
    )
    
    //MARK: - Mock CommunityHome
    
    static let mockCommunityHome1 = CommunityHome(
        id: 971,
        name: "Warsaw technology fans",
        description: "A community for technology lovers to share and learn.",
        avatar: mockImage2,
        members: [mockUser1, mockUser2, mockUser3],
        latitude: 52.237049,
        longitude: 21.017523,
        isPublic: true
    )
    
    static let mockCommunityHome2 = CommunityHome(
        id: 345,
        name: "Starosielce",
        description: "A vibrant local community in Starosielce, promoting neighborhood cooperation and cultural exchange.",
        avatar: mockImage1,
        members: [mockUser1, mockUser2],
        latitude: 53.1333,
        longitude: 23.16433,
        isPublic: false
    )
    
    static let mockCommunityHome3 = CommunityHome(
        id: 654,
        name: "Apple enjoyers Cafilornia",
        description: "Apple Enjoyers California is a community for enthusiasts to discuss the latest Apple products, share tips, and connect with like-minded fans.",
        avatar: nil,
        members: [mockUser1, mockUser2],
        latitude: 37.7749,
        longitude: -122.4194,
        isPublic: true
    )
    
    //MARK: - Mock CommunityProfile
    
    static let mockCommunityProfile1 = CommunityProfile(
        id: 971,
        name: "Warsaw technology fans",
        description: "A community for technology lovers to share and learn.",
        avatar: mockImage2,
        members: [mockUser1, mockUser2, mockUser3],
        administrators: [mockUser1],
        isPublic: true
    )
    
    
    //MARK: - Mock CommunityDetail
    
    static let mockCommunityDetail = CommunityDetail(
        id: 762,
        name: "Starosielce Community",
        description: "A vibrant local community in Starosielce, promoting neighborhood cooperation and cultural exchange.",
        background: mockImage1,
        administrators: [mockUser1],
        members: [mockUser3],
        //issues: [mockIssue1],
        joinRequests: [mockJoinRequest1, mockJoinRequest2],
        latitude: 53.1305,
        longitude: 23.1799,
        isPublic: true
    )
    
    //MARK: - Mock Issue
    
   // static let mockIssue1 = Issue(id: 3)
    
    //MARK: - Mock JoinRequest
    
    static let mockJoinRequest1 = JoinRequest(
        id: 78,
        user: mockUser2,
        userId: 5678,
        status: .pending
    )
    
    static let mockJoinRequest2 = JoinRequest(
        id: 90765,
        user: mockUser3,
        userId: 9012,
        status: .accepted
    )
}
