//
//  SignUpView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct SignUpView: View {
    
    @Binding var showSignInView: Bool
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var repeatPassword: String = ""
    
    var body: some View {
        ZStack {
            
            Color(hex: "#F2F2F2")
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                TextField("Email...", text: $email)
                    .defaultTextFieldStyle()
                
                SecureField("Password...", text: $password)
                    .defaultTextFieldStyle()
                
                SecureField("Repeat Password...", text: $password)
                    .defaultTextFieldStyle()
                
                Button(action: {
                    showSignInView = false
                }) {
                    Text("Sign Up")
                        .defaultButtonStyle()
                }
                
                Spacer()
            }
            .navigationTitle("Sign Up")
            .padding(.top)
        }
    }
}

#Preview {
    NavigationStack {
        SignUpView(showSignInView: .constant(false))
    }
}
