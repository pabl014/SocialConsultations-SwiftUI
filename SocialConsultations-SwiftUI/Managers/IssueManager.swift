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
    
//    @AppStorage("authToken") private var authToken: String?
    
    func fetchIssues(communityID: Int, pageNumber: Int, pageSize: Int) async throws -> [Issue] {
        
        let urlString = "\(Secrets.issuesURL)?communityId=\(communityID)&PageNumber=\(pageNumber)&PageSize=\(pageSize)&Fields=Id,Title,Description,IssueStatus,CreatedAt"
//        print("Generated URL: \(urlString)")
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
    
}
