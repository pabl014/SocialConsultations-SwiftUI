//
//  CreateIssueView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 29/11/2024.
//

import SwiftUI
import PhotosUI

struct CreateIssueView: View {
    
    let communityId: Int
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = CreateIssueViewModel()
    
    
    @State private var isShowingFilePicker: Bool = false
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section(header: Text("Issue Title")) {
                    TextField("Enter title", text: $viewModel.title)
                }
                
                Section(header: Text("Description") .onTapGesture {
                    dismissKeyboard()
                }) {
                    TextEditor(text: $viewModel.description)
                        .frame(height: 150)
                }
                
                Section(header: Text("Add Photos")) {
                    
                    PhotosPicker(selection: $viewModel.selectedPhotos, maxSelectionCount: 5, matching: .images) {
                        HStack {
                            Image(systemName: "photo")
                            Text("Select Photos")
                        }
                    }
                    .onChange(of: viewModel.selectedPhotos) {
                        Task {
                            await viewModel.loadSelectedPhotos(viewModel.selectedPhotos)
                        }
                    }
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.images, id: \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .itemCornerRadius(10)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                
                Section(header: Text("Add Files")) {
                    Button(action: {
                        isShowingFilePicker = true
                    }) {
                        HStack {
                            Image(systemName: "doc")
                            Text("Select Files")
                        }
                    }
                    
                    ForEach(viewModel.selectedFiles, id: \.self) { file in
                        Text(file.lastPathComponent)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Section(header: Text("Current State End Date")) {
                    DatePicker(
                        "Select date:",
                        selection: $viewModel.currentStateEndDate,
                        in: Date()...,
                        displayedComponents: .date
                    )
                    .padding(.horizontal, 20)
                }
                
                Section {
                    VStack {
                        if viewModel.isSubmitting {
                            ProgressView("Submitting...")
                        } else {
                            Button("Submit Issue") {
                                Task {
                                    await viewModel.createIssue(for: communityId)
                                    dismiss()
                                }
                            }
                            .disabled(viewModel.title.isEmpty || viewModel.description.isEmpty)
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowingFilePicker) {
                FilePicker { urls in
                    viewModel.addUniqueFiles(from: urls)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateIssueView(communityId: 89)
    }
}
