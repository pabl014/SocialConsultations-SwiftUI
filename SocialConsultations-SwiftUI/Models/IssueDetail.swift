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
    let community: String?
    let communityId: Int
    let files: [FileData]
    let solutions: [Solution]
    let issueStatus: IssueStatus
    let comments: [Comment]
    let createdAt: String
    let currentStateEndDate: String
}
