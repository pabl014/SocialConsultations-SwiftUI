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
    
    func searchCommunities(withName name: String, pageNumber: Int, pageSize: Int) async throws -> [CommunityDTO] {
        
        let urlString = "\(Secrets.communitiesURL)?PageNumber=\(pageNumber)&PageSize=\(pageSize)&SearchQuery=\(name)&Fields=Id,Name"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let responseDTO = try decoder.decode(CommunityResponseDTO.self, from: data)
        
        return responseDTO.value
    }
}
