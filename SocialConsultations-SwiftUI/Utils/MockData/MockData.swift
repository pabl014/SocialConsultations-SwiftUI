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
    
    //MARK: - Mock IssueDetail
    
    static let mockIssueDetail = IssueDetail(
        id: 198,
        title: "Barcelona New Stadium",
        description: "The stadium in Barcelona requires significant renovations to meet modern standards and enhance the fan experience. Upgrading the infrastructure will not only improve safety and comfort but also allow the venue to host a wider range of international events. These changes are crucial for boosting the club's revenue and maintaining its reputation as a world-class sports destination.",
        community: nil,
        communityId: 101,
        files: [
            FileData(id: 98, data: Base64examples.example64, description: "Photo", type: 0),
            FileData(id: 1, data: Base64examples.pdf1_base64, description: "Major_document_1.pdf", type: 1),
            FileData(id: 2, data: Base64examples.example64_3, description: "Photo1", type: 0),
            FileData(id: 7, data: Base64examples.pdf2_base64, description: "form_2.pdf", type: 1)
        ],
        solutions: [
            Solution(id: 19,
                     title: "Reduce Maintenance Costs",
                     description: "Implement energy-efficient systems and reduce unnecessary expenditures to lower the stadium's maintenance costs.",
                     files: [
                        FileData(id: 987, data: Base64examples.example64_3, description: "Photo_solution_1", type: 0),
                        FileData(id: 1, data: Base64examples.pdf1_base64, description: "Major_document_1.pdf", type: 1),
                     ],
                     userVotes: [],
                     issueId: 198),
            Solution(id: 20, title: "Improve Accessibility", description: "Enhance public transport options and create better parking facilities to improve accessibility to the stadium.", files: [], userVotes: [], issueId: 198),
            Solution(id: 21, title: "Increase Capacity", description: "Expand seating capacity to accommodate a growing fan base while maintaining safety and comfort.", files: [], userVotes: [], issueId: 198)
        ],
        issueStatus: .gatheringInformation,
        comments: [
            //            Comment(id: 1),
            //            Comment(id: 2)
        ],
        createdAt: "2024-11-24T08:00:00Z",
        currentStateEndDate: "2024-12-31T23:59:59Z"
    )
    
    
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
    
    //MARK: - Mock UserForUpvote
    
    static let mockUserForUpvote1 = UserForUpvote(
        id: 178,
        name: "Didier",
        surname: "Drogba",
        email: "drogba@ijgjg.com",
        birthDate: "jjrgjrgrg",
        confirmed: true
    )
    
    //MARK: - Mock Comment
    
    static let mockComment1 = Comment(
        id: 789,
        author: mockUser2,
        authorId: mockUser2.id,
        issue: mockIssueForComment1,
        content: "The new Barcelona stadium is a true marvel of modern architecture. It perfectly combines cutting-edge technology with the club's rich history, creating a space that will inspire players and fans for generations to come. A fitting home for one of the greatest football clubs in the world!",
        upvotes: [mockUserForUpvote1],
        createdAt: "2024-12-31T23:59:59Z",
        issueStatus: .gatheringInformation
    )
    
    //MARK: - Mock IssueForComment
    
    static let mockIssueForComment1 = IssueForComment(
        id: 67, title: "siemson", description: "blabla", communityId: 6, issueStatus: .feedbackCollection, createdAt: "2024-10-31T23:59:59Z", currentStateEndDate: "2024-12-31T23:59:59Z")
    
    //MARK: - Mock Solution
    
    static let mockSolution1 = Solution(
        id: 19,
        title: "Reduce Maintenance Costs",
        description: "Implement energy-efficient systems and reduce unnecessary expenditures to lower the stadium's maintenance costs.",
        files: [
            FileData(id: 987, data: Base64examples.example64_3, description: "Photo_solution_1", type: 0),
            FileData(id: 1, data: Base64examples.pdf1_base64, description: "Major_document_1.pdf", type: 1),
            FileData(id: 98, data: Base64examples.example64, description: "Photo", type: 0),
            FileData(id: 7, data: Base64examples.pdf2_base64, description: "form_2.pdf", type: 1),
            FileData(id: 7, data: Base64examples.pdf2_base64, description: "form_2.pdf", type: 1),
            FileData(id: 7, data: Base64examples.pdf2_base64, description: "form_2.pdf", type: 1),
            FileData(id: 7, data: Base64examples.pdf2_base64, description: "form_2.pdf", type: 1),
            FileData(id: 7, data: Base64examples.pdf2_base64, description: "form_2.pdf", type: 1)
        ], userVotes: [],
        issueId: 198
    )
    
    static let mockSolution2 = Solution(
        id: 24,
        title: "Hire Leo Messi",
        description: "Leo Messi, footballer born in argentina is a world-class player and a great ambassador for the club.",
        files: [
            FileData(id: 987, data: Base64examples.example64_3, description: "Photo_solution_1", type: 0),
            FileData(id: 1, data: Base64examples.pdf1_base64, description: "Major_document_1.pdf", type: 1),
        ], userVotes: [],
        issueId: 198
    )
}
