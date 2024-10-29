//
//  AuthenticationManager.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 29/10/2024.
//

import Foundation

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() { }
    
    func login(email: String, password: String) async throws -> String {
        
        let endpoint = "https://example.com/login"
        
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        let body = LoginRequestBody(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            throw AuthenticationError.failedToEncodeRequestBody
        }
        
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            do {
                let responseBody = try JSONDecoder().decode(LoginResponseBody.self, from: data)
                
                if let token = responseBody.token, responseBody.success == true {
                    return token
                } else {
                    throw AuthenticationError.invalidCredentials(responseBody.message ?? "Invalid login credentials")
                }
            } catch {
                throw AuthenticationError.failedToDecodeResponse
            }
        } catch {
            throw error
        }
    }
}
