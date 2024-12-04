//
//  SolutionsViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 03/12/2024.
//

import Foundation


@MainActor
final class SolutionsViewModel: ObservableObject {
    
    @Published var solutions: [Solution] = []
    @Published var user: User?
    @Published var isLoading: Bool = false
    @Published var errorMessage: ErrorMessage?
    
    
    func fetchCurrentUser() async {
        do {
            self.user = try await UserManager.shared.fetchCurrentUser()
        } catch {
            print("Error in fetching current user in commentViewModel: \(error.localizedDescription)")
        }
    }
    
    func fetchSolutions(for issueId: Int) async {
        
        isLoading = true
        
        do {
            let fetchedSolutions = try await IssueManager.shared.fetchSolutions(issueID: issueId)
            self.solutions = fetchedSolutions
        } catch {
            print("Error fetching solutions: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    func voteForSolution(solutionId: Int) async -> Bool {
        
        do {
            try await IssueManager.shared.upvoteSolution(solutionId: solutionId)
            print("Successfully voted for solution with id: \(solutionId)")
            
            if let index = solutions.firstIndex(where: { $0.id == solutionId }) {
                solutions[index].userVotes.append(UserForUpvote(
                    id: user?.id ?? -1,
                    name: "Temporary",
                    surname: "User",
                    email: "temp@example.com",
                    birthDate: "2000-01-01",
                    confirmed: true
                ))
            }
            
            return true
            
        } catch {
            errorMessage = ErrorMessage(message: "Failed to vote for solution. \n The operation couldn’t be completed.")
            print("Error voting for solution: \(error.localizedDescription)")
            return false 
        }
    }
}
