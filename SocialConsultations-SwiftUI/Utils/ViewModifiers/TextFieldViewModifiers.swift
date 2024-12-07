//
//  TextFieldViewModifiers.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 22/10/2024.
//

import SwiftUI


struct TextFieldViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(height: 50)
            .background(.gray.opacity(0.4))
            .itemCornerRadius(10)
            .padding(.horizontal)
    }
}

extension View {
    
    func defaultTextFieldStyle() -> some View {
        self.modifier(TextFieldViewModifier())
    }
}


#Preview {
    VStack(spacing: 16){
        TextField("Email...", text: .constant(""))
            .defaultTextFieldStyle()
        
        SecureField("Password...", text: .constant(""))
            .defaultTextFieldStyle()
        
        SecureField("Repeat Password...", text: .constant(""))
            .defaultTextFieldStyle()
        
        Text("Sign Up")
            .defaultButtonStyle()
    }
}
