//
//  IssueForCreationDTO.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 29/11/2024.
//

import Foundation

struct IssueForCreationDTO: Codable {
    let title: String
    let description: String
    let communityId: Int
    let files: [FileDataForCreationDto]
    let currentStateEndDate: String
}
