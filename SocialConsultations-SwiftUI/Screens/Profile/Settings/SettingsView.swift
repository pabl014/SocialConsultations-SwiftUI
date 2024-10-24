//
//  SettingsView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button(role: .destructive) {
                showSignInView = true
            } label: {
                Text("Log out")
            }
            
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}
