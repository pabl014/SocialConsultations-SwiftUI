//
//  CommunityForCreationDTO.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 30/11/2024.
//

import Foundation

struct CommunityForCreationDTO: Codable {
    let name: String
    let description: String
    let avatar: FileDataForCreationDto
    let Background: FileDataForCreationDto
    let latitude: Double
    let longitude: Double
    let isPublic: Bool
}
