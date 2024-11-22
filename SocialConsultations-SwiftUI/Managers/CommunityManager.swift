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
    
    func fetchCommunities(pageNumber: Int, pageSize: Int) async throws -> [CommunityHome] {
        
        let urlString = "\(Secrets.communitiesURL)?PageNumber=\(pageNumber)&PageSize=\(pageSize)&Fields=Id,Name,Description,Avatar,Members,Latitude,Longitude,IsPublic"
        
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
        let communities = try decoder.decode(CommunityHomeResponse.self, from: data)
        
        return communities.value
    }
    
    func fetchClosestCommunities(at location: CLLocationCoordinate2D) async throws -> [CommunityHome] {
        
        let latitude: Double = Double(location.latitude)
        let longitude: Double = Double(location.longitude)
        
        let urlString = Secrets.closestURL
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "longitude": longitude,
            "latitude": latitude,
            "maxDistanceKm": 100,
            "fields": ["Id", "Name", "Description", "Avatar", "Members", "Latitude", "Longitude", "IsPublic"]
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
        } catch {
            throw URLError(.cannotParseResponse)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let closestCommunities = try JSONDecoder().decode([CommunityHome].self, from: data)
            return closestCommunities
        } catch {
            throw URLError(.cannotDecodeContentData)
        }
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
    
    func fetchCommunityDetails(withId id: Int) async throws -> CommunityDetail {
        
        let urlString = "\(Secrets.communitiesURL)/\(id)?Fields=Id,Name,Description,Background,Administrators,Members,Issues,JoinRequests,Latitude,Longitude,IsPublic"
        
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
        let community = try decoder.decode(CommunityDetail.self, from: data)
        
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
