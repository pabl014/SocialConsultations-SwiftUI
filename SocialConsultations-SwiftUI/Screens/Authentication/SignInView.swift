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
        VStack(spacing: 16) {
            TextField("Email...", text: $email)
                .padding()
                .frame(height: 50)
                .background(.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            
            SecureField("Password...", text: $password)
                .padding()
                .frame(height: 50)
                .background(.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            
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

#Preview {
    NavigationStack {
        SignInView(showSignInView: .constant(false))
    }
    
}
