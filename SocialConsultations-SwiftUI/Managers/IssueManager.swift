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
    
    func createIssue(from data: IssueForCreationDTO) async throws {
        
        let urlString = Secrets.issuesURL
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        guard let authToken else {
            throw URLError(.userAuthenticationRequired)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try JSONEncoder().encode(data)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
    
    func updateIssueStatus(issueId: Int, newStatus: Int, completionDate: String) async throws {
        
        let urlString = "\(Secrets.issuesURL)/\(issueId)"
        
        guard let authToken else {
            throw URLError(.userAuthenticationRequired)
        }
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json-patch+json", forHTTPHeaderField: "Content-Type")
        
        var body: [[String: Any]] = []
        
        body.append([
            "operationType": 0,
            "path": "/issueStatus",
            "op": "replace",
            "from": "",
            "value": "\(newStatus)"
        ])
        
        body.append([
            "operationType": 0,
            "path": "/currentStateEndDate",
            "op": "replace",
            "from": "",
            "value": completionDate
        ])
        
        let jsonData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        request.httpBody = jsonData
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { // tutaj oczekiwany 204
            throw URLError(.badServerResponse)
        }
    }
    
    func updateIssueDescription(issueId: Int, description: String) async throws {
        
        let urlString = "\(Secrets.issuesURL)/\(issueId)"
        
        guard let authToken else {
            throw URLError(.userAuthenticationRequired)
        }
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json-patch+json", forHTTPHeaderField: "Content-Type")
        
        var body: [[String: Any]] = []
        
        body.append([
            "operationType": 0,
            "path": "/description",
            "op": "replace",
            "from": "",
            "value": description
        ])
        
        let jsonData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        request.httpBody = jsonData
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { // tutaj oczekiwany 204
            throw URLError(.badServerResponse)
        }
    }
    
    //MARK: - Solutions
    
    func fetchSolutions(issueID: Int) async throws -> [Solution] {
        
        let urlString = "\(Secrets.solutionsURL)?issueId=\(issueID)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/vnd.socialconsultations.solution.full+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        #warning("no-cache fetchSolutions")
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        request.setValue("no-cache", forHTTPHeaderField: "Pragma")
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()

        let solutions = try decoder.decode(SolutionResponse.self, from: data)
        
        return solutions.value
    }
    
    func upvoteSolution(solutionId: Int) async throws {
        
        let urlString = "\(Secrets.solutionsURL)/\(solutionId)/upvotes"
        
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
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Status code: \(httpResponse.statusCode)")
        }

        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
    
    
    //MARK: - Comments
    
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
