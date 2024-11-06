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
        
        let endpoint = Secrets.authenticationURL
        
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
                guard let responseString = String(data: data, encoding: .utf8) else { // response is String: token or "Wrong username or password"
                    throw AuthenticationError.failedToDecodeResponse
                }
                
                if responseString != "Wrong username or password" {
                    return responseString
                } else {
                    throw AuthenticationError.invalidCredentials("Invalid login credentials")
                }
            } catch {
                print("nie dziaua")
                throw AuthenticationError.failedToDecodeResponse
            }
        } catch {
            throw AuthenticationError.invalidCredentials("Invalid login credentials")
        }
    }
    
    
    func createUser(from user: UserRequest) async throws {
        
        let endpoint = Secrets.usersURL
        
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            throw AuthenticationError.failedToEncodeRequestBody
        }
        
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            print("User created successfully. Please check your email to activate your account.")
            
        } catch {
            throw error
        }
    }
    
    func resetPassword(email: String) async throws {
        
        let endpoint = Secrets.resetPasswordURL
        
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonBody = "\"\(email)\""
        request.httpBody = jsonBody.data(using: .utf8)
        
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("Body being sent: \(bodyString)")
        }
        
        do {
            
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 else {
                throw AuthenticationError.invalidEmail
            }

        } catch {
            throw error
        }
    }
}
