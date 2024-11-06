//
//  ForgotPasswordView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 06/11/2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @StateObject private var viewModel = ForgotPasswordViewModel()
    @State private var email: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            if viewModel.isOperationSuccessful {
                CheckEmailView()
                    .transition(.push(from: .top))
                    .navigationBarBackButtonHidden()
            } else {
                TextField("Email...", text: $email)
                    .defaultTextFieldStyle()
                
                Button {
                    Task {
                        await viewModel.resetPassword(email: email)
                    }
                } label: {
                    Text("Reset")
                        .defaultButtonStyle()
                }

                Spacer()
            }
        }
        .padding(.top)
        .navigationTitle("Request a password reset")
        .navigationBarTitleDisplayMode(.inline)
        .alert(item: $viewModel.errorMessage) { errorMessage in
            Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
        }
        .animation(.default, value: viewModel.isOperationSuccessful)
    }
}

#Preview {
    NavigationStack {
        ForgotPasswordView()
    }
}
