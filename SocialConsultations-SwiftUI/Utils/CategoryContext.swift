//
//  CategoryContext.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 15/10/2024.
//

enum CategoryContext: CaseIterable, Identifiable {
    case current
    case finished
    
    var id: Self { self }
    
    var title: String {
        switch self {
            case .current: return "Current"
            case .finished: return "Finished"
        }
    }
}
