//
//  CommunityManager.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 07/11/2024.
//

import Foundation

final class CommunityManager {
    
    static let shared = CommunityManager()
    private init() {}
    
    func fetchCommunities() async throws -> [Community] {
        
        let urlString = Secrets.communitiesURL
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/vnd.socialconsultations.community.full+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let communities = try decoder.decode(CommunityResponse.self, from: data)
        
        return communities.value
    }
}
