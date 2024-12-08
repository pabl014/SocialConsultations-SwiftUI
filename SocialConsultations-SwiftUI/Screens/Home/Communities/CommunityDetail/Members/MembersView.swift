//
//  MembersView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 29/11/2024.
//

import SwiftUI

struct MembersView: View {
    
    let communityId: Int
    let isAdmin: Bool
    
    @State private var selectedMember: User?
    @State private var showAlert = false
    @State private var searchText = ""
    
    @StateObject private var viewModel = MembersViewModel()
    
    var body: some View {
        
        Group {
            if viewModel.isLoading {
                ProgressView("Loading Members...")
            } else if viewModel.members.isEmpty {
                noMembers
            } else {
                membersList
            }
        }
        .searchable(text: $searchText, prompt: "Search by surname")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Image(systemName: imageName(for: viewModel.members.count))
                        .foregroundColor(.gray)
                    Text(String(viewModel.members.count))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .alert("Confirm Removal", isPresented: $showAlert, actions: {
            Button("Remove", role: .destructive) {
                if let member = selectedMember {
                    Task {
                        await viewModel.deleteMember(member, communityId: communityId)
                    }
                }
            }
            Button("Cancel", role: .cancel, action: {})
        }, message: {
            if let member = selectedMember {
                Text("Are you sure you want to remove \(member.name) \(member.surname)?")
            }
        })
        .onAppear {
            Task {
                await viewModel.fetchMembers(for: communityId)
            }
        }
        
    }
    
    var noMembers: some View {
        ContentUnavailableView(
            "No members",
            systemImage: "person.slash.fill"
        )
    }
    
    var membersList: some View {
        
        List(filteredMembers, id: \.id) { member in
            
            NavigationLink(destination: UserProfileView(userId: member.id)) {
                VStack(alignment: .leading) {
                    Text("\(member.name) \(member.surname)")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(member.email)
                        .font(.subheadline)
                }
            }
            .contextMenu {
                if isAdmin {
                    Button(role: .destructive) {
                        selectedMember = member
                        showAlert = true
                    } label: {
                        Label("Remove", systemImage: "trash")
                    }
                }
            }
        }
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
    
    private var filteredMembers: [User] {
        if searchText.isEmpty {
            return viewModel.members
        } else {
            return viewModel.members.filter { $0.surname.lowercased().hasPrefix(searchText.lowercased()) }
        }
    }
}

#Preview {
    NavigationStack {
        MembersView(communityId: 77, isAdmin: true)
    }
}
