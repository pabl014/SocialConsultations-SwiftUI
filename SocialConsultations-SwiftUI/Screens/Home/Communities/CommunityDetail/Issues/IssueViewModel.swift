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
    
    func isGatheringInformation() -> Bool {
        
        guard let issue else { return false }
        return issue.issueStatus == .gatheringInformation
    }
    
    func isCompleted() -> Bool {
        
        guard let issue else { return false }
        return issue.issueStatus == .completed
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
    
    func updateDescription(description: String) async {
        
        guard let issue else { return }
        
        do {
            try await IssueManager.shared.updateIssueDescription(
                issueId: issue.id,
                description: description
            )
        } catch {
            print("failed to update issue description in viewModel")
        }
    }
}

        
