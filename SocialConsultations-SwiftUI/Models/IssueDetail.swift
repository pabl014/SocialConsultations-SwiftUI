//
//  IssueDetail.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 25/11/2024.
//

import Foundation

struct IssueDetail: Codable {
    let id: Int
    let title: String
    let description: String
    let community: Community?
    let communityId: Int
    let files: [FileData]
    let solutions: [Solution]
    let issueStatus: Int
    let comments: [Comment]
    let createdAt: Date
    let currentStateEndDate: Date
}
