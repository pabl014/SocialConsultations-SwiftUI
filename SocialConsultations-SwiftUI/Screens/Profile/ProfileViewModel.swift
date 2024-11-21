//
//  ProfileViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 04/11/2024.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var errorMessage: ErrorMessage?
//    @Published var isLoading: Bool = false
    
    func fetchCurrentUser() async {
        do {
            self.user = try await UserManager.shared.fetchCurrentUser()
        } catch {
            errorMessage = ErrorMessage(message: error.localizedDescription)
        }
    }
    
    func fetchUser(with id: Int) async {
        do {
            self.user = try await UserManager.shared.fetchUserData(userId: id)
        } catch {
            errorMessage = ErrorMessage(message: error.localizedDescription)
        }
    }
}
