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
            
            if let token = authToken {
                Text("Auth Token: \(token)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            } else {
                Text("No Auth Token found")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            Text(viewModel.user?.name ?? "no name")
            
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

struct EditProfileSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: SettingsViewModel
    
    @State private var newName: String = ""
    @State private var newSurname: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("New name...", text: $newName)
                TextField("New surname...", text: $newSurname)
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        Task {
                            await viewModel.updateUserProfileIfNeeded(name: newName, surname: newSurname)
                        }
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            newName = viewModel.user?.name ?? ""
            newSurname = viewModel.user?.surname ?? ""
        }
        .alert(item: $viewModel.errorMessage) { errorMessage in
            Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
        }
    }
}
