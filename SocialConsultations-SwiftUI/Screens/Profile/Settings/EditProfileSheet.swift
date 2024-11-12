//
//  EditProfileSheet.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 06/11/2024.
//

import SwiftUI
import PhotosUI

struct EditProfileSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: SettingsViewModel
    
    @State private var newName: String = ""
    @State private var newSurname: String = ""
    @State private var newBirthDate: Date = Date()
    @State private var avatarItem: PhotosPickerItem? = nil // Binding for PhotosPickerItem
    @State private var avatarData: Data? = nil // Stores selected image data
    @State private var avatarFileData: FileDataForCreationDto? = nil // Stores FileDataForCreationDto object for avatar on submit
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("User data")) {
                    TextField("New name...", text: $newName)
                        .autocorrectionDisabled()
                    TextField("New surname...", text: $newSurname)
                        .autocorrectionDisabled()
                    DatePicker("Birthday", selection: $newBirthDate, in: ...Date(), displayedComponents: .date)
                }
                
                Section(header: Text("Avatar")) {
                    let uiImage = avatarData.flatMap { UIImage(data: $0) }
                    
                    if let uiImage = uiImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 120, height: 120)
                            .padding()
                        
                        Button("Remove Avatar") {
                            avatarData = nil
                            avatarFileData = nil
                        }
                        .foregroundColor(.red)
                        
                    } else {
                        Image(systemName: "person.crop.circle.fill.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                    }
                    
                    PhotosPicker(selection: $avatarItem, matching: .images, photoLibrary: .shared()) {
                        Text("Choose Avatar")
                    }
                    .onChange(of: avatarItem) {
                        if let avatarItem {
                            Task {
                                do {
                                    // Load image data
                                    if let data = try await avatarItem.loadTransferable(type: Data.self) {
                                        avatarData = data
                                        avatarFileData = FileDataForCreationDto(data: data.base64EncodedString(), description: "User avatar", type: 0)
                                    }
                                } catch {
                                    print("Failed to load image data: \(error)")
                                }
                            }
                        }
                    }
                }
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
                            await viewModel.updateUserProfileIfNeeded(name: newName, surname: newSurname, birthDate: birthDateString, avatar: avatarFileData)
                        }
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            newName = viewModel.user?.name ?? ""
            newSurname = viewModel.user?.surname ?? ""
            newBirthDate = viewModel.user?.birthDate.fromISO8601toDate() ?? Date()
            
            if let avatar = viewModel.user?.avatar {
                // Decode `FileData` from API
                avatarData = Data(base64Encoded: avatar.data)
            }
        }
        .alert(item: $viewModel.errorMessage) { errorMessage in
            Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
        }
    }
}
#Preview {
    SettingsView(showSignInView: .constant(false))
}
