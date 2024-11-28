//
//  Comment.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 25/11/2024.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let author: User?
    let authorId: Int
    let issue: IssueForComment?
    let content: String
    var upvotes: [UserForUpvote]
    let createdAt: String
    let issueStatus: IssueStatus
}


