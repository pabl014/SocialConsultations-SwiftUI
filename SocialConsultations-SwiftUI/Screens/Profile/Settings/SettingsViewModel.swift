//
//  SettingsViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 29/10/2024.
//

import Foundation
import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @AppStorage("authToken") private var authToken: String?
    
    func logout() {
        authToken = nil
    }
}
