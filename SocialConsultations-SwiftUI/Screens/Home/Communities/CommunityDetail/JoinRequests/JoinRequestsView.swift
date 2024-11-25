//
//  JoinRequestsView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 19/11/2024.
//

import SwiftUI

struct JoinRequestsView: View {
    
    let joinRequests: [JoinRequest]
    let communityId: Int
    
    
    @StateObject private var viewModel = JoinRequestsViewModel()
    @State private var selectedStatus: InviteStatus? = .pending
    
    var body: some View {
        
        VStack {
            if viewModel.filteredRequests(for: selectedStatus).isEmpty {
                noRequests
            } else {
                List(viewModel.filteredRequests(for: selectedStatus), id: \.id) { request in
                    NavigationLink(destination: UserProfileView(userId: request.userId)) {
                        JoinRequestCell(request: request)
                    }
                    .swipeActions(allowsFullSwipe: true) {
                        if request.status == .pending {
                            Button(role: .destructive) {
                                Task {
                                    await viewModel.rejectRequest(request.id)
                                }
                            } label: {
                                Label("Reject", systemImage: "person.fill.xmark")
                            }
                        }
                        
                    }
                    .swipeActions(edge:.leading, allowsFullSwipe: true) {
                        if request.status == .pending {
                            Button(role: .destructive) {
                                Task {
                                    await viewModel.acceptRequest(request.id)
                                }
                            } label: {
                                Label("Accept", systemImage: "face.smiling.inverse")
                            }
                            .tint(.green)
                        }
                    }
                }
            }
        }
        .navigationTitle("Join Requests")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Picker("Filter", selection: $selectedStatus) {
                    //                    Text("All")
                    //                        .tag(nil as InviteStatus?) // Tag for showing all statuses
                    ForEach(InviteStatus.allCases, id: \.self) { status in
                        Text(status.displayName)
                            .tag(status as InviteStatus?) // Tag for individual statuses
                    }
                }
                //.pickerStyle(MenuPickerStyle())
                .pickerStyle(NavigationLinkPickerStyle())
            }
        }
        .onAppear {
            viewModel.setup(joinRequests, communityId)
        }
        .refreshable {
            
        }
    }
    
    var noRequests: some View {
        ContentUnavailableView(
            "No join requests",
            systemImage: "xmark"
            //description: Text("You need to write at least 3 letters to start searching")
        )
    }
}

#Preview {
    NavigationStack {
        JoinRequestsView(joinRequests: MockData.mockCommunityDetail.joinRequests, communityId: 2)
    }
}


struct JoinRequestCell: View {
    
    let request: JoinRequest
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 16) {
            if let user = request.user {
                VStack(alignment: .leading) {
                    Text("\(user.name) \(user.surname)")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(user.email)
                        .font(.subheadline)
                    
                    Text("Status: \(request.status)")
                        .font(.subheadline)
                }
            } else {
                Text("Cannot fetch user data")
            }
        }
    }
}
