//
//  SettingsViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 29/10/2024.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @AppStorage("authToken") private var authToken: String?
    @Published var user: User?
    @Published var errorMessage: ErrorMessage?
    
    func logout() {
        authToken = nil
    }
    
    func fetchCurrentUser() async {
        do {
            self.user = try await UserManager.shared.fetchCurrentUser()
        } catch {
            errorMessage = ErrorMessage(message: error.localizedDescription)
        }
    }
    
    func updateUserProfileIfNeeded(name: String, surname: String, birthDate: String, avatar: FileDataForCreationDto?) async {
        guard let userId = user?.id else { return }
        
        let nameChanged = !name.isEmpty && name != user?.name
        let surnameChanged = !surname.isEmpty && surname != user?.surname
        let birthDateChanged = !birthDate.isEmpty && birthDate != user?.birthDate
        let avatarChanged = avatar != nil
        
        if nameChanged || surnameChanged || birthDateChanged || avatarChanged {
            do {
                try await UserManager.shared.updateUserProfile(
                    userId: userId, name: nameChanged ? name : nil,
                    surname: surnameChanged ? surname : nil,
                    birthDate: birthDateChanged ? birthDate : nil,
                    avatar: avatarChanged ? avatar : nil
                )
                
                await fetchCurrentUser() // Reload user data
            } catch {
                errorMessage = ErrorMessage(message: error.localizedDescription)
            }
        }
    }
}
