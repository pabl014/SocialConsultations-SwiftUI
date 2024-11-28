//
//  IssueManager.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 25/11/2024.
//

import Foundation
import SwiftUI

final class IssueManager {
    
    static let shared = IssueManager()
    private init() {}
    
    @AppStorage("authToken") private var authToken: String?
    
    func fetchIssues(communityID: Int, pageNumber: Int, pageSize: Int) async throws -> [Issue] {
        
        let urlString = "\(Secrets.issuesURL)?communityId=\(communityID)&PageNumber=\(pageNumber)&PageSize=\(pageSize)&Fields=Id,Title,Description,IssueStatus,CreatedAt"
//        print("Generated URL: \(urlString)")
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        guard let authToken else {
            throw URLError(.userAuthenticationRequired)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/vnd.socialconsultations.issue.full+json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()

        let issuesResponse = try decoder.decode(IssueResponse.self, from: data)
        
        return issuesResponse.value
    }
    
    func fetchIssueDetails(issueID: Int) async throws -> IssueDetail {
        
        let urlString = "\(Secrets.issuesURL)/\(issueID)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/vnd.socialconsultations.issue.full+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()

        let issue = try decoder.decode(IssueDetail.self, from: data)
        
        return issue
    }
    
    
    func fetchComments(issueID: Int, orderBy: String) async throws -> [Comment] {
        
        let urlString = "\(Secrets.commentsURL)?issueId=\(issueID)&OrderBy=\(orderBy)"
//        print(urlString)
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/vnd.socialconsultations.comment.full+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        //request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
//        if let httpResponse = response as? HTTPURLResponse {
//            print("Status code: \(httpResponse.statusCode)")
//        }
//        
//        if let responseString = String(data: data, encoding: .utf8) {
//            print("Response body: \(responseString)") // Debugowanie odpowiedzi
//        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()

        let comments = try decoder.decode(CommentsResponse.self, from: data)
        
        return comments.value
    }
    
    
    func addComment(authorID: Int, issueId: Int, content: String, issueStatus: IssueStatus) async throws {
        
        let urlString = Secrets.commentsURL
        
        guard let authToken else {
            throw URLError(.userAuthenticationRequired)
        }
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = CommentRequest(authorId: authorID, issueId: issueId, content: content, issueStatus: issueStatus.rawValue)
        
        
        request.httpBody = try JSONEncoder().encode(body)
        
//        if let jsonBody = String(data: request.httpBody ?? Data(), encoding: .utf8) {
//            print("Request body: \(jsonBody)")
//        }
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
//        if let httpResponse = response as? HTTPURLResponse {
//            print("Status code: \(httpResponse.statusCode)")
//        }
//        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
    
    func upvoteComment(commentId: Int) async throws {
        
        let urlString = "\(Secrets.commentsURL)/\(commentId)/upvotes"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        guard let authToken else {
            throw URLError(.userAuthenticationRequired)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
//        if let httpResponse = response as? HTTPURLResponse {
//            print("Status code: \(httpResponse.statusCode)")
//        }
//        
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}
