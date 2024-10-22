//
//  View+Ext.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 12/10/2024.
//

import SwiftUI

extension View {
    
    public func itemCornerRadius(_ radius: CGFloat) -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: radius))
    }
}
