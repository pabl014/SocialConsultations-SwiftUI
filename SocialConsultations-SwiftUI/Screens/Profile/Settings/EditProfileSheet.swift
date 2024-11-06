//
//  EditProfileSheet.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 06/11/2024.
//

import SwiftUI

struct EditProfileSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: SettingsViewModel
    
    @State private var newName: String = ""
    @State private var newSurname: String = ""
    @State private var newBirthDate: Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("New name...", text: $newName)
                TextField("New surname...", text: $newSurname)
                DatePicker("Birthday", selection: $newBirthDate, in: ...Date(), displayedComponents: .date)
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
                            let birthDateString = newBirthDate.toISO8601String()
                            await viewModel.updateUserProfileIfNeeded(name: newName, surname: newSurname, birthDate: birthDateString)
                        }
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            newName = viewModel.user?.name ?? ""
            newSurname = viewModel.user?.surname ?? ""
            newBirthDate = viewModel.user?.birthDate.toISO8601Date() ?? Date()
            
        }
        .alert(item: $viewModel.errorMessage) { errorMessage in
            Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    NavigationStack {
        EditProfileSheet(viewModel: SettingsViewModel())
    }
}
