//
//  CommentRequest.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 27/11/2024.
//

import Foundation

struct CommentRequest: Codable {
    let authorId: Int
    let issueId: Int
    let content: String
    let issueStatus: Int
}
