//
//  AuthenticationView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack {
            
            Color(hex: "#F2F2F2")
                .ignoresSafeArea()
            
            VStack {
                Image(systemName: "globe.europe.africa")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(.blue)
                
                Text("Social Consultations")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 50)
                
                VStack(spacing: 16) {
                    NavigationLink {
                        SignInView(showSignInView: $showSignInView)
                    } label: {
                        Text("Log In")
                            .defaultButtonStyle()
                    }
                    
                    NavigationLink {
                        SignUpView(showSignInView: $showSignInView)
                    } label: {
                        Text("Sign Up")
                            .secondaryButtonStyle()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AuthenticationView(showSignInView: .constant(false))
    }
}
