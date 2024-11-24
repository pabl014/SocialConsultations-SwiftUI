//
//  CommunityCategoryContext.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 24/11/2024.
//

import Foundation

enum CommunityCategoryContext: CaseIterable, Identifiable {
    case member
    case admin
    
    var id: Self { self }
    
    var title: String {
        switch self {
            case .member: return "Member"
            case .admin: return "Admin"
        }
    }
}
