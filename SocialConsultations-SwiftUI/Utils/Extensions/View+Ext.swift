//
//  View+Ext.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 12/10/2024.
//

import SwiftUI

extension View {
    
    func itemCornerRadius(_ radius: CGFloat) -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: radius))
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
