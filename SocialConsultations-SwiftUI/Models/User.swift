//
//  User.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 04/11/2024.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let surname: String
    let birthDate: String
    let email: String
    let confirmed: Bool
    let confirmationCode: String
    let avatar: FileData?
}
