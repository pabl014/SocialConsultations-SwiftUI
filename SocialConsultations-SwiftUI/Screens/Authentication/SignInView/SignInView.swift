//
//  SignInView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject private var viewModel = SignInViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack {
            Color(hex: "#F2F2F2")
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                TextField("Email...", text: $viewModel.email)
                    .defaultTextFieldStyle()
                    .keyboardType(.emailAddress)
                
                SecureField("Password...", text: $viewModel.password)
                    .defaultTextFieldStyle()
                
                NavigationLink {
                    ForgotPasswordView()
                } label: {
                    Text("I forgot my password")
                        .padding(.leading, 20)
                        .font(.subheadline)
                }

                
                Button(action: {
                    Task {
                        await viewModel.login()
                        if viewModel.errorMessage == nil {
                            showSignInView = false
                        }
                    }
                }) {
                    Text("Log In")
                        .defaultButtonStyle()
                }
                
                Spacer()
            }
            .navigationTitle("Log In")
            .padding(.top)
        }
        .onTapGesture {
            dismissKeyboard()
        }
        .alert(item: $viewModel.errorMessage) { errorMessage in
            Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
        }
        
    }
}

#Preview {
    NavigationStack {
        SignInView(showSignInView: .constant(false))
    }
}
