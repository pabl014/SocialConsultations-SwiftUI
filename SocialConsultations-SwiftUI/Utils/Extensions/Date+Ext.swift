//
//  Date+Ext.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 30/10/2024.
//

import Foundation

extension Date {
    
    func toISO8601String() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: self)
    }
}
