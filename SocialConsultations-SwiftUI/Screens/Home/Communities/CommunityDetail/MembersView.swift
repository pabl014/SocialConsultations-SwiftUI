//
//  MembersView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 29/11/2024.
//

import SwiftUI

struct MembersView: View {
    
    let members: [User]
    
    var body: some View {
        if members.isEmpty {
            noMembers
        } else {
            List(members, id: \.id) { member in
                
                NavigationLink(destination: UserProfileView(userId: member.id)) {
                    VStack(alignment: .leading) {
                        Text("\(member.name) \(member.surname)")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(member.email)
                            .font(.subheadline)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Image(systemName: imageName(for: members.count))
                            .foregroundColor(.gray)
                        Text(String(members.count))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
    var noMembers: some View {
        ContentUnavailableView(
            "No members",
            systemImage: "person.slash.fill"
        )
    }
    
    private func imageName(for count: Int) -> String {
        switch count {
        case ..<50:
            return "person.fill"
        case 50..<100:
            return "person.2.fill"
        default:
            return "person.3.fill"
        }
    }
}

#Preview {
    NavigationStack {
        MembersView(members: [MockData.mockUser1, MockData.mockUser2])
    }
}
