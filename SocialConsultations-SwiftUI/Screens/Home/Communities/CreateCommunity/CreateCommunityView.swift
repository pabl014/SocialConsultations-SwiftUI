//
//  CreateCommunityView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 29/11/2024.
//

import SwiftUI
import CoreLocation
import PhotosUI

struct CreateCommunityView: View {
    
    let location: CLLocationCoordinate2D?
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = CreateCommunityViewModel()
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Enter Name", text: $viewModel.name)
                }
                
                Section(header: Text("Description") .onTapGesture {
                    dismissKeyboard()
                }) {
                    TextEditor(text: $viewModel.description)
                        .frame(height: 150)
                }
                
                Section(header: Text("Avatar")) {
                    PhotosPicker(selection: $viewModel.selectedAvatar, matching: .images) {
                        HStack {
                            HStack {
                                Image(systemName: "photo")
                                Text("Select Photo")
                            }
                            
                            Spacer()
                            
                            Button("Remove") {
                                viewModel.avatarImage = nil
                                viewModel.selectedAvatar = nil
                            }
                            .foregroundColor(.red)
                        }
                        
                    }
                    .onChange(of: viewModel.selectedAvatar) {
                        Task {
                            viewModel.avatarImage = await viewModel.loadSelectedPhoto(from: viewModel.selectedAvatar)
                        }
                    }
                    
                    if let avatarImage = viewModel.avatarImage {
                        VStack {
                            Image(uiImage: avatarImage)
                                .resizable()
                                .scaledToFit()
                                .itemCornerRadius(20)
                                .frame(width: 150, height: 150)
                        }
                    }
                }
                
                Section(header: Text("Select Background")) {
                    PhotosPicker(selection: $viewModel.selectedBackground, matching: .images) {
                        HStack {
                            HStack {
                                Image(systemName: "photo")
                                Text("Select Photo")
                            }
                            
                            Spacer()
                            
                            Button("Remove") {
                                viewModel.backgroundImage = nil
                                viewModel.selectedBackground = nil
                            }
                            .foregroundColor(.red)
                        }
                    }
                    .onChange(of: viewModel.selectedBackground) {
                        Task {
                            viewModel.backgroundImage = await viewModel.loadSelectedPhoto(from: viewModel.selectedBackground)
                        }
                    }
                    
                    if let backgroundImage = viewModel.backgroundImage {
                        VStack {
                            Image(uiImage: backgroundImage)
                                .resizable()
                                .scaledToFit()
                                .itemCornerRadius(20)
                                .frame(width: 200, height: 200)
                        }
                    }
                }
                
                Section(header: Text("Location").onTapGesture {
                    dismissKeyboard()
                }) {
                    HStack {
                        Text("Latitude:")
                            .font(.subheadline)
                        TextField("Enter Latitude", text: $viewModel.latitudeText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: viewModel.latitudeText) {
                                viewModel.latitudeText = viewModel.latitudeText.replacingOccurrences(of: ",", with: ".")
                            }
                    }
                    
                    HStack {
                        Text("Longitude:")
                            .font(.subheadline)
                        TextField("Enter Longitude", text: $viewModel.longitudeText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: viewModel.longitudeText) {
                                viewModel.longitudeText = viewModel.longitudeText.replacingOccurrences(of: ",", with: ".")
                            }
                    }
                }
                
                Section(header: Text("Privacy")) {
                    Toggle(isOn: $viewModel.isPublic) {
                        Text("is Public: ")
                    }
                }
                
                Section {
                    VStack {
                        if viewModel.isSubmitting {
                            ProgressView("Submitting...")
                        } else {
                            Button("Create Community") {
                                viewModel.isSubmitting = true
                                
                                Task {
                                    await viewModel.createCommunity()
                                    dismiss()
                                }
                            }
                            .disabled(
                                !viewModel.validateInputs()
                            )
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                viewModel.latitudeText = location?.latitude.description ?? ""
                viewModel.longitudeText = location?.longitude.description ?? ""
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateCommunityView(location: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522))
    }
}
