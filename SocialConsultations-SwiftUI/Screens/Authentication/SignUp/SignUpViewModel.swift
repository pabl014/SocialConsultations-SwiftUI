//
//  SignUpViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 29/10/2024.
//

import Foundation


@MainActor
final class SignUpViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var birthDate: Date = Date()
    
    @Published var errorMessage: ErrorMessage?
    @Published var isSignUpSuccessful: Bool = false
    
    
    func createUser() async {
        
        guard ValidateInputs() else { return }
        
        let birthDateISO8601 = birthDate.toISO8601String()
        
        let newUser = UserRequest(name: name, surname: surname, password: password, email: email, birthDate: birthDateISO8601)
        
        do {
            try await AuthenticationManager.shared.createUser(from: newUser)
            isSignUpSuccessful = true
            // clearTextFields()
            
        } catch {
            errorMessage = ErrorMessage(message: error.localizedDescription)
        }
    }
    
    private func ValidateInputs() -> Bool {
        
        if email.isEmpty {
            errorMessage = ErrorMessage(message: "Please enter your email address.")
            return false
        } else if !email.isValidEmail {
            errorMessage = ErrorMessage(message: "Please enter a valid email address.")
            return false
        }
        
        if name.isEmpty {
            errorMessage = ErrorMessage(message: "Please enter your name.")
            return false
        } else if !name.isValidNameLength {
            errorMessage = ErrorMessage(message: "Name must be between 1 and 20 characters.")
            return false
        }
        
        if surname.isEmpty {
            errorMessage = ErrorMessage(message: "Please enter your surname.")
            return false
        } else if !surname.isValidSurnameLength {
            errorMessage = ErrorMessage(message: "Surname must be between 1 and 30 characters.")
            return false
        }
        
        if password.isEmpty {
            errorMessage = ErrorMessage(message: "Please enter your password.")
            return false
        } else if !password.isValidPasswordLength {
            errorMessage = ErrorMessage(message: "Password must be between 7 and 20 characters.")
            return false
        }
        
        if confirmPassword.isEmpty {
            errorMessage = ErrorMessage(message: "Please confirm your password.")
            return false
        } else if !confirmPassword.matches(password) {
            errorMessage = ErrorMessage(message: "Passwords do not match.")
            return false
        }
        
        errorMessage = nil
        return true
    }
    
//    private func clearTextFields() {
//         email = ""
//         name = ""
//         surname = ""
//         password = ""
//         confirmPassword = ""
//         birthDate = Date()
//    }
    
    
    
    //MARK: - Do testowania offline:
    
    func testCreateUser() async {
        await simulateUserCreation()
    }
    
    private func simulateUserCreation() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 sekunda
        isSignUpSuccessful = true
    }
}
