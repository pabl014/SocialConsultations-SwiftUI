//
//  UserForUpvote.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 26/11/2024.
//

import Foundation

struct UserForUpvote: Codable {
    let id: Int
    let name: String
    let surname: String
    let email: String
    let birthDate: String
    let confirmed: Bool
}
