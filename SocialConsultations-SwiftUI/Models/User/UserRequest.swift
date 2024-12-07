//
//  UserRequest.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 29/10/2024.
//

import Foundation

struct UserRequest: Codable {
    let name: String
    let surname: String
    let password: String
    let email: String
    let birthDate: String
}


/*
 {
   "name": "string",
   "surname": "string",
   "password": "strings",
   "email": "user@example.com",
   "birthDate": "2024-10-30T00:23:59.714Z"
 }
 */
