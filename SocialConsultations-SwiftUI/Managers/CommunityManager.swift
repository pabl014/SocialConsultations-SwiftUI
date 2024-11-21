//
//  CommunityManager.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 07/11/2024.
//

import Foundation
import CoreLocation
import SwiftUI

final class CommunityManager {
    
    static let shared = CommunityManager()
    private init() {}
    
    @AppStorage("authToken") private var authToken: String?
    
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
    
    func fetchClosestCommunities(at location: CLLocationCoordinate2D) async throws -> Community {
        
        let latitude = location.latitude
        let longitude = location.longitude
        
        let urlString = Secrets.communitiesURL
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        return MockData.mockCommunity
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
    
    func fetchCommunityDetails(withId id: Int) async throws -> Community {
        
        let urlString = "\(Secrets.communitiesURL)/\(id)"
        
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
        let community = try decoder.decode(Community.self, from: data)
        
        return community
    }
    
    func sendJoinRequest(toCommunity communityId: Int) async throws {
        
        let urlString = "\(Secrets.communitiesURL)/\(communityId)/joinrequests"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        guard let authToken else {
            throw URLError(.userAuthenticationRequired)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
    
    func updateJoinRequestStatus(communityId: Int, joinRequestId: Int, status: InviteStatus) async throws {
        
        var urlString: String
    
        switch status {
        case .accepted:
            urlString = "\(Secrets.communitiesURL)/\(communityId)/joinrequests/\(joinRequestId)/accept"
        case .rejected:
            urlString = "\(Secrets.communitiesURL)/\(communityId)/joinrequests/\(joinRequestId)/reject"
        case .pending:
            throw URLError(.badURL)
        }
        
        print("URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        guard let authToken else {
            throw URLError(.userAuthenticationRequired)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" 
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}
