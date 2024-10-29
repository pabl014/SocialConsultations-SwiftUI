//
//  LoginResponseBody.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 29/10/2024.
//

import Foundation

struct LoginResponseBody: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}
