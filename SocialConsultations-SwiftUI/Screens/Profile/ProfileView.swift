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
    @State private var isLoading = true
    
    var body: some View {
        VStack {
            if isLoading {
                LoadingView() // Ekran ładowania
                    .frame(width: 100, height: 100)
                    .padding()
            } else {
                // Wyświetl avatar lub placeholder po załadowaniu danych użytkownika
                ImageBase64View(base64String: viewModel.user?.avatar?.data)
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .padding()
                
                Text(viewModel.user?.name ?? "no name")
                Text(viewModel.user?.surname ?? "no surname")
                Text(viewModel.user?.email ?? "no email")
                Text(viewModel.user?.birthDate.toPrettyDateString() ?? "no birth date")
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchCurrentUser()
                isLoading = false // Wyłącz ekran ładowania po pobraniu danych
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
