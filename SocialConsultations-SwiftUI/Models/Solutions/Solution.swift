//
//  Solution.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 25/11/2024.
//

import Foundation

struct Solution: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let files: [FileData]
    var userVotes: [UserForUpvote]
    let issueId: Int
}

