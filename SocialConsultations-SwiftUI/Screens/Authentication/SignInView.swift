//
//  SignInView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct SignInView: View {
    
    @Binding var showSignInView: Bool
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            
            Color(hex: Constants.SCWhite)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                TextField("Email...", text: $email)
                    .defaultTextFieldStyle()
                
                SecureField("Password...", text: $password)
                    .defaultTextFieldStyle()
                
                Button(action: {
                    showSignInView = false
                }) {
                    Text("Log In")
                        .defaultButtonStyle()
                }
                
                Spacer()
            }
            .navigationTitle("Log In")
            .padding(.top)
        }
        
    }
}

#Preview {
    NavigationStack {
        SignInView(showSignInView: .constant(false))
    }
    
}
