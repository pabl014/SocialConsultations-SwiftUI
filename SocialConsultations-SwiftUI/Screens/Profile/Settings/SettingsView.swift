//
//  SettingsView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @AppStorage("authToken") private var authToken: String?
    
    @Binding var showSignInView: Bool
    @State private var isShowingEditProfileSheet: Bool = false
    
    var body: some View {
        List {
            Button(role: .destructive) {
                viewModel.logout()
                showSignInView = true
            } label: {
                Text("Log out")
            }
            
            Button {
                isShowingEditProfileSheet.toggle()
            } label: {
                Text("Edit profile")
            }
            
        }
        .sheet(isPresented: $isShowingEditProfileSheet) {
            EditProfileSheet(viewModel: viewModel)
        }
        .navigationTitle("Settings")
        .onAppear {
            Task {
                await viewModel.fetchCurrentUser()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}
