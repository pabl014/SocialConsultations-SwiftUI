//
//  String+Ext.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 29/10/2024.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        let emailRegex: String = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidNameLength: Bool {
        return self.count >= 1 && self.count <= 20
    }
    
    var isValidSurnameLength: Bool {
        return self.count >= 1 && self.count <= 30
    }
    
    var isValidPasswordLength: Bool {
        return self.count >= 7 && self.count <= 20
    }
    
    func matches(_ other: String) -> Bool {
        return self == other
    }
    
    
    func toPrettyDateString() -> String {
        
        let components = self.split { $0 == "-" || $0 == "T" }
        
        guard components.count >= 3 else { return self } // returns original string, if format is bad
        
        let months = [
            "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
        ]
        
        let year = components[0]
        let monthIndex = Int(components[1]) ?? 1
        let day = components[2].trimmingCharacters(in: .whitespaces)
        
        // Data format to "1 January 1998"
        if monthIndex >= 1 && monthIndex <= 12 {
            let month = months[monthIndex - 1]
            return "\(day) \(month) \(year)"
        } else {
            return self
        }
    }
    
    func toISO8601Date() -> Date? {
        let iso8601Formatter = ISO8601DateFormatter()
        return iso8601Formatter.date(from: self)
    }
}
