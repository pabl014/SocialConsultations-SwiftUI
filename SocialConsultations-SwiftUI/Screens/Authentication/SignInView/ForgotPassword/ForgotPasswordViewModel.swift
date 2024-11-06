//
//  ForgotPasswordViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 06/11/2024.
//

import Foundation

@MainActor
final class ForgotPasswordViewModel: ObservableObject {
    
    @Published var isOperationSuccessful: Bool = false
    @Published var errorMessage: ErrorMessage?
    
    func resetPassword(email: String) async {
        
        guard validateInput(email: email) else { return }
        
        do {
            try await AuthenticationManager.shared.resetPassword(email: email)
            isOperationSuccessful = true
        } catch {
            errorMessage = ErrorMessage(message: "No account is associated with this email.")
        }
    }
    
    private func validateInput(email: String) -> Bool {
        if email.isEmpty {
            errorMessage = ErrorMessage(message: "Please enter your email address.")
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
