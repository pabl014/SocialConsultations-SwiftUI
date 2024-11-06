//
//  ProfileView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @Binding var showSignInView: Bool
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.user?.name ?? "no name")
            Text(viewModel.user?.surname ?? "no surname")
            Text(viewModel.user?.email ?? "no email")
            Text(viewModel.user?.birthDate.toPrettyDateString() ?? "no birth date")
        }
        .onAppear {
            Task {
                await viewModel.fetchCurrentUser()
            }
        }
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
