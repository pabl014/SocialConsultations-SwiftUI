//
//  ButtonViewModifiers.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 22/10/2024.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(.blue)
            .itemCornerRadius(10)
            .shadow(color: .blue.opacity(0.2), radius: 10, x: 0, y: 10)
            .padding(.horizontal)
    }
}


struct SecondaryButtonViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.blue)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.blue, lineWidth: 2)
                    .shadow(color: .blue.opacity(0.2), radius: 10, x: 0, y: 10)
            )
            .padding(.horizontal)
    }
}


extension View {
    
    func defaultButtonStyle() -> some View {
        self.modifier(DefaultButtonViewModifier())
    }
    
    func secondaryButtonStyle() -> some View {
        self.modifier(SecondaryButtonViewModifier())
    }
}


struct ButtonViewModifiers: View {
    var body: some View {
        Text("Default button")
            .defaultButtonStyle()
            .padding(.bottom)
        
        Text("Secondary Button")
            .secondaryButtonStyle()
        
    }
}

#Preview {
    ButtonViewModifiers()
}
