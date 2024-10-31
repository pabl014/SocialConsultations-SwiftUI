//
//  SignUpView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct SignUpView: View {
    
    @Binding var showSignInView: Bool
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        ZStack {
            
            Color(hex: "#F2F2F2")
                .ignoresSafeArea()
            
            if viewModel.isSignUpSuccessful {
                ActivateAccount(showSignInView: $showSignInView)
                    .transition(.push(from: .top))
                    .navigationBarBackButtonHidden()
            } else {
                VStack(spacing: 16) {
                    TextField("Email...", text: $viewModel.email)
                        .defaultTextFieldStyle()
                    
                    TextField("Enter your name...", text: $viewModel.name)
                        .defaultTextFieldStyle()
                    
                    TextField("Enter your surname...", text: $viewModel.surname)
                        .defaultTextFieldStyle()
                    
                    DatePicker("Birthdate", selection: $viewModel.birthDate, in: ...Date(), displayedComponents: .date)
                        .padding(.horizontal, 20)
                    
                    SecureField("Password...", text: $viewModel.password)
                        .defaultTextFieldStyle()
                    
                    SecureField("Repeat Password...", text: $viewModel.confirmPassword)
                        .defaultTextFieldStyle()
                    
                    Button(action: {
                        Task {
                            await viewModel.createUser()
                        }
                    
                    }) {
                        Text("Sign Up")
                            .defaultButtonStyle()
                    }
                    
                    Spacer()
                }
                .navigationTitle("Sign Up")
                .padding(.top)
                .alert(item: $viewModel.errorMessage) { errorMessage in
                    Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
                }
            }
        }
        .animation(.default, value: viewModel.isSignUpSuccessful)
    }
}

#Preview {
    NavigationStack {
        SignUpView(showSignInView: .constant(false))
    }
}
