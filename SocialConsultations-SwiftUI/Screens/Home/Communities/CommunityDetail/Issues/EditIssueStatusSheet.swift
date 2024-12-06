//
//  EditIssueStatusSheet.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 06/12/2024.
//

import SwiftUI

struct EditIssueStatusSheet: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: IssueViewModel
    
    @State private var selectedStatus: IssueStatus = .gatheringInformation
    @State private var originalStatus: IssueStatus?
    
    @State private var completionDate: Date = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section {
                    Text("Change to: \(nextStatus()?.description ?? originalStatus?.description ?? "Unknown")")
                        .font(.headline)
                        .bold()
                    Text("Current: \(originalStatus?.description ?? "Unknown")")
                        .font(.footnote)
                    
                }
                
                Section(header: Text("Completion Date")) {
                    DatePicker("Select Date", selection: $completionDate, in: Date()..., displayedComponents: .date)
                }
            }
            .navigationTitle("Change status")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            await saveChanges()
                        }
                    }
                }
            }
        }
        .onAppear {
            if let issue = viewModel.issue {
                if originalStatus == nil {
                    originalStatus = issue.issueStatus
                    selectedStatus = issue.issueStatus
                }
            }
        }
    }
    
    private func nextStatus() -> IssueStatus? {
        
        guard let original = originalStatus,
              let currentIndex = IssueStatus.allCases.firstIndex(of: original),
              currentIndex < IssueStatus.allCases.count - 1 else {
            return nil
        }
        
        return IssueStatus.allCases[currentIndex + 1]
    }
    
    private func saveChanges() async {
        
        guard let next = nextStatus() else { return }
        
        await viewModel.updateIssueStatus(newStatus: next.rawValue, completionDate: completionDate)
        
        dismiss()
    }
}


