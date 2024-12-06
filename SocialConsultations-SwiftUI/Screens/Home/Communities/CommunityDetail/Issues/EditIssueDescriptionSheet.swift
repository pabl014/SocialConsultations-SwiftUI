//
//  EditIssueDescriptionSheet.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 06/12/2024.
//

import SwiftUI

struct EditIssueDescriptionSheet: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: IssueViewModel
    
    @State private var newDescription: String = ""
    @State private var originalDescription: String = ""
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Description")) {
                    TextEditor(text: $newDescription)
                        .frame(height: 600)
                }
            }
            .navigationTitle("Edit description")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            await viewModel.updateDescription(description: newDescription)
                        }
                        dismiss()
                    }
                    .disabled(newDescription == originalDescription)
                }
            }
        }
        .onAppear {
            if let issue = viewModel.issue {
                newDescription = issue.description
                originalDescription = issue.description
            }
        }
    }
}

