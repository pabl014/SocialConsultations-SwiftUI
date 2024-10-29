//
//  SignInViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 29/10/2024.
//

import Foundation
import SwiftUI

@MainActor
final class SignInViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: ErrorMessage?
    
    @AppStorage("authToken") private var authToken: String?
    
    func login() async {
        
        guard ValidateInputs() else { return }
        
        do {
            let token = try await AuthenticationManager.shared.login(email: email, password: password)
            authToken = token
            errorMessage = nil
        } catch let error as AuthenticationError {
            errorMessage = ErrorMessage(message: error.localizedDescription)
        } catch {
            errorMessage = ErrorMessage(message: "An unexpected error occured: \(error.localizedDescription)")
        }
    }
    
    
    private func ValidateInputs() -> Bool {
        if email.isEmpty {
            errorMessage = ErrorMessage(message: "Please enter your email address.")
            return false
        }
        
        if password.isEmpty {
            errorMessage = ErrorMessage(message: "Please enter your password.")
            return false
        }
        
        if email.isValidEmail == false {
            errorMessage = ErrorMessage(message: "Please enter a valid email address.")
            return false 
        }
        
        errorMessage = nil
        return true
    }
}

