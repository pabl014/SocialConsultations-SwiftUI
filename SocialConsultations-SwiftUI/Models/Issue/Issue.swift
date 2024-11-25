//
//  Issue.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 07/11/2024.
//

import Foundation

struct Issue: Codable, Equatable {
    let id: Int
    let title: String
    let description: String
    let issueStatus: IssueStatus
    let createdAt: String
    
    static func == (lhs: Issue, rhs: Issue) -> Bool {
        return lhs.id == rhs.id
    }
}


