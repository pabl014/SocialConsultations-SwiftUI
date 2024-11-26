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
}
