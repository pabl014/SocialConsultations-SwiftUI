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
        VStack {
            TextField("Email...", text: $email)
                .padding()
                .background(.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            SecureField("Password...", text: $password)
                .padding()
                .background(.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Button(action: {
                showSignInView = false
            }) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Spacer()
            
           
        }
        .padding()
        .navigationTitle("Sign In")
        
    }
}

#Preview {
    NavigationStack {
        SignInView(showSignInView: .constant(false))
    }
    
}
