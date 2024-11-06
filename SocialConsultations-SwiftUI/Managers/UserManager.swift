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
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // print JSON data to the console
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
           let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
           let jsonString = String(data: prettyData, encoding: .utf8) {
            print("Received JSON data:\n\(jsonString)")
        } else {
            print("Could not parse JSON data")
        }
        
        
        let user = try JSONDecoder().decode(User.self, from: data)
        print(user)
        return user
    }
    
    
   func updateUserProfile(userId: Int, name: String?, surname: String?) async throws {
       
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
       
       let jsonData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
       
       if let jsonString = String(data: jsonData, encoding: .utf8) {
           print("Wysyłane body: \(jsonString)")
       }
       
       request.httpBody = jsonData// konwersja obiektu body (tablica slownikow [String:Any] na dane JSON, ktore moga byc uzyte do httpBody
       
       print("PROBA ZMIANY")
       
       let (_, response) = try await URLSession.shared.data(for: request)
       
       guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
           print("bad response")
           throw URLError(.badServerResponse)
       }
       
       print("Kod statusu odpowiedzi: \(httpResponse.statusCode)")
   }
    
}