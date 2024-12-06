//
//  IssueViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 26/11/2024.
//

import Foundation


@MainActor
final class IssueViewModel: ObservableObject {
    
    @Published var issue: IssueDetail?
    @Published var isLoading = false
    
    func loadIssueDetails(from id: Int) async {
        
        isLoading = true
        
        do {
            let issue = try await IssueManager.shared.fetchIssueDetails(issueID: id)
            self.issue = issue
        } catch {
            print(error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func showAddSolution() -> Bool {
        
        guard let issue else { return false }
        
        if issue.issueStatus != .gatheringInformation {
            return false
        } else {
            return true
        }
    }
    
    func updateIssueStatus(newStatus: Int, completionDate: Date) async {
        
        guard let issue else { return }
        
        let dateString = completionDate.toISO8601String()
        
        guard dateString != issue.currentStateEndDate else {
            return
        }
        
        do {
            try await IssueManager.shared.updateIssueStatus(
                issueId: issue.id,
                newStatus: newStatus,
                completionDate: dateString
            )
        } catch {
            print("failed to update issue status in viewModel")
        }
    }
}

        
