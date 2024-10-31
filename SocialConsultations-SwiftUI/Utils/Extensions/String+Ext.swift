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
}
