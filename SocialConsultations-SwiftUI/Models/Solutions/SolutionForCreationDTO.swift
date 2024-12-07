//
//  SolutionForCreationDTO.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 06/12/2024.
//

import Foundation

struct SolutionForCreationDTO: Codable {
    let title: String
    let description: String
    let files: [FileDataForCreationDto]
    let issueId: Int
}
