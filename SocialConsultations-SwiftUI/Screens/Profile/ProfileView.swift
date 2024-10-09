//
//  ProfileView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        Text("ProfileView")
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingsView(showSignInView: $showSignInView)
                    } label: {
                        HStack {
                            Image(systemName: "gear")
                                .font(.headline)
                            Text("Settings")
                        }
                    }
                }
            }
    }
}

#Preview {
    NavigationStack {
        ProfileView(showSignInView: .constant(false))
    }
}
