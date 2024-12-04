//
//  CommentsViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 26/11/2024.
//

import Foundation

@MainActor
final class CommentsViewModel: ObservableObject {
    
    @Published var comments: [Comment] = []
    @Published var user: User?
    @Published var isLoading = false
    @Published var sortOrder: String = "Id%20desc"
    
    func fetchCurrentUser() async {
        do {
            self.user = try await UserManager.shared.fetchCurrentUser()
        } catch {
            print("Error in fetching current user in commentViewModel: \(error.localizedDescription)")
        }
    }
    
    func fetchComments(for issueID: Int) async {
        
        isLoading = true
        
        do {
            self.comments = try await IssueManager.shared.fetchComments(issueID: issueID, orderBy: sortOrder)
        } catch {
            print("Error in fetching comments in commentViewModel: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    func addComment(issueID: Int, content: String, issueStatus: IssueStatus) async {
        
        guard let userId = user?.id, !content.isEmpty else { return }
        
        do {
            try await IssueManager.shared.addComment(
                authorID: userId,
                issueId: issueID,
                content: content,
                issueStatus: issueStatus
            )
        } catch {
            print("nie udalo sie zapostowac komentarza: \(error.localizedDescription)")
        }
    }
    
    func upvoteComment(commentId: Int) async {
        do {
            try await IssueManager.shared.upvoteComment(commentId: commentId)
            print("Successfully upvoted comment with ID: \(commentId)")
            
            if let index = comments.firstIndex(where: { $0.id == commentId }) {
                comments[index].upvotes.append(UserForUpvote(
                    id: user?.id ?? -1,
                    name: "Temporary",
                    surname: "User",
                    email: "temp@example.com",
                    birthDate: "2000-01-01",
                    confirmed: true
                ))
            }
        } catch {
            print("Failed to upvote comment with ID: \(commentId): \(error.localizedDescription)")
        }
    }
}
