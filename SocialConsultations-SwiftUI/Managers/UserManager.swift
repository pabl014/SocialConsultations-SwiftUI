//
//  UserManager.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 04/11/2024.
//

import SwiftUI

final class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    @AppStorage("authToken") private var authToken: String?
    
    func fetchCurrentUser() async throws -> User {
        
        let endpoint = Secrets.selfURL
        
        guard let authToken else {
            throw URLError(.userAuthenticationRequired)
        }
        
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        // request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/vnd.socialconsultations.user.full+json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let user = try JSONDecoder().decode(User.self, from: data)
        //print(user)
        print(authToken)
        return user
    }
    
    func fetchUserData(userId: Int) async throws -> User {
        
        let endpoint = Secrets.usersURL + "/" + String(userId)
        
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/vnd.socialconsultations.user.full+json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let user = try JSONDecoder().decode(User.self, from: data)
        
        return user
    }
    
    
    func updateUserProfile(userId: Int, name: String?, surname: String?, birthDate: String?, avatar: FileDataForCreationDto?, description: String?) async throws {
        
        let endpoint = Secrets.usersURL + "/" + String(userId)
        
        guard let authToken else {
            throw URLError(.userAuthenticationRequired)
        }
        
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json-patch+json", forHTTPHeaderField: "Content-Type")
        
        var body: [[String: Any]] = []
        
        if let name = name, !name.isEmpty {
            body.append([
                "operationType": 0,
                "path": "/name",
                "op": "replace",
                "from": "",
                "value": name
            ])
        }
        
        if let surname = surname, !surname.isEmpty {
            body.append([
                "operationType": 0,
                "path": "/surname",
                "op": "replace",
                "from": "",
                "value": surname
            ])
        }
        
        if let birthDate = birthDate, !birthDate.isEmpty {
            body.append([
                "operationType": 0,
                "path": "/birthDate",
                "op": "replace",
                "from": "",
                "value": birthDate
            ])
        }
        
        if let avatar = avatar {
            body.append([
                "operationType": 0,
                "path": "/avatar",
                "op": "replace",
                "from": "",
                "value": [
                    "data": avatar.data,
                    "description": avatar.description,
                    "type": avatar.type
                ]
            ])
        }
        
        if let description = description {
            body.append([
                "operationType": 0,
                "path": "/description",
                "op": "replace",
                "from": "",
                "value": description
            ])
        }
        
        let jsonData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)

        request.httpBody = jsonData
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
    
}
