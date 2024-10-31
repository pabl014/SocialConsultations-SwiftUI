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
            Color(hex: Constants.SCWhite)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                TextField("Email...", text: $viewModel.email)
                    .defaultTextFieldStyle()
                
                SecureField("Password...", text: $viewModel.password)
                    .defaultTextFieldStyle()
                
                Button(action: {
                    Task {
                        await viewModel.login()
                        if viewModel.errorMessage == nil {
                            showSignInView = false
                        }
                    }
                    // showSignInView = false
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
