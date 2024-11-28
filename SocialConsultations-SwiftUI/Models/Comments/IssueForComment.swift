//
//  IssueForComment.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 28/11/2024.
//

import Foundation

struct IssueForComment: Codable {
    let id: Int
    let title: String
    let description: String
    let communityId: Int
    let issueStatus: IssueStatus
    let createdAt: String
    let currentStateEndDate: String
}

