//
//  FileData.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 06/11/2024.
//

import Foundation

struct FileData: Codable, Identifiable {
    let id: Int
    let data: String // base64 string zawsze
    let description: String
    let type: Int    // 0 -> image, 1-> other
}
