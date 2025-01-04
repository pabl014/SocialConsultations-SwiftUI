//
//  SectionViewModifier.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 19/11/2024.
//

import SwiftUI

struct SectionViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .itemCornerRadius(20)
            .shadow(radius: 5)
            .padding()
    }
}

extension View {
    
    func sectionShadowStyle() -> some View {
        self.modifier(SectionViewModifier())
    }
}


#Preview {
    VStack(spacing: 16){
        
        Image("desert")
            .resizable()
            .scaledToFit()
            .itemCornerRadius(10)
            .sectionShadowStyle()
        
        
        
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
            .sectionShadowStyle()
    }
}
