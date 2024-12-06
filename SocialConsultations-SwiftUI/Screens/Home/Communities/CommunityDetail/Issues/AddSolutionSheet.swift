//
//  AddSolutionSheet.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 06/12/2024.
//

import SwiftUI
import PhotosUI

struct AddSolutionSheet: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: IssueViewModel
    
    @State private var selectedPhotos: [PhotosPickerItem] = []
    @State private var isShowingFilePicker: Bool = false
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $viewModel.title)
                }
                
                Section(header: Text("Description") .onTapGesture {
                    dismissKeyboard()
                }) {
                    TextEditor(text: $viewModel.description)
                        .frame(height: 150)
                }
                
                Section(header: Text("Add Photos")) {
                    
                    PhotosPicker(selection: $selectedPhotos, maxSelectionCount: 5, matching: .images) {
                        HStack {
                            Image(systemName: "photo")
                            Text("Select Photos")
                         }
                    }
                    .onChange(of: selectedPhotos) {
                        Task {
                            await viewModel.loadSelectedPhotos(selectedPhotos)
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
                
                Section {
                    VStack {
                        if viewModel.isSubmitting {
                            ProgressView("Submitting...")
                        } else {
                            Button("Submit Solution") {
                                Task {
                                    await viewModel.createSolution()
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
