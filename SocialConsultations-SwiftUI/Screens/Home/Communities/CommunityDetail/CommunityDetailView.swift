//
//  CommunityDetailView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/11/2024.
//

import SwiftUI

struct CommunityDetailView: View {
    
    let communityID: Int
    
    @StateObject private var viewModel = CommunityDetailViewModel()
    
    @State private var isShowingCreateIssueView = false
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let loadedCommunity = viewModel.community {
                ScrollView(.vertical) {
                    CommunityHeader(community: loadedCommunity)
                    
                    ExpandableMapView(lat: Double(loadedCommunity.latitude), long: Double(loadedCommunity.longitude))
                    
                    if viewModel.isAdmin() {
                        NavigationLink {
                            JoinRequestsView(joinRequests: loadedCommunity.joinRequests, communityId: loadedCommunity.id)
                        } label: {
                            Text("See join requests")
                                .defaultButtonStyle()
                        }
                    }
                    
                    if viewModel.isAdmin() || viewModel.isMember() {
                        NavigationLink {
                            MembersView(communityId: loadedCommunity.id, isAdmin: viewModel.isAdmin())
                        } label: {
                            HStack(spacing: 2) {
                                Text("See Members")
                                Text("(\(loadedCommunity.members.count))")
                            }
                            .defaultButtonStyle()
                        }
                    }
                    
                    if viewModel.isMember() || viewModel.isAdmin() {
                        
                        Issues
                        
                        LazyVStack(spacing: 4) {
                            ForEach(viewModel.issues, id: \.id) { issue in
                                NavigationLink {
                                    IssueView(id: issue.id, isAdministrator: viewModel.isAdmin())
                                } label: {
                                    IssueCell(issue: issue)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .onAppear {
                                    if issue == viewModel.issues.last && !viewModel.isLoadingIssues {
                                        Task {
                                            await viewModel.fetchIssues(for: communityID)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                Text("Community details could not be loaded.")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle(viewModel.community?.name ?? "Community")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                toolbarStatus()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchCommunityDetails(id: communityID)
                await viewModel.fetchCurrentUser()
                await viewModel.fetchIssues(for: communityID)
            }
        }
        .refreshable {
            Task {
                await viewModel.refreshIssues(for: communityID)
            }
        }
        .sheet(isPresented: $isShowingCreateIssueView) {
            CreateIssueView(communityId: communityID)
        }
    }
    
    
    @ViewBuilder
    private func toolbarStatus() -> some View {
        if viewModel.isAdmin() {
            RequestStatus(imageName: "bolt.shield", text: "Admin")
                .foregroundStyle(.green)
        } else if viewModel.isMember() {
            RequestStatus(imageName: "person", text: "Member")
                .foregroundStyle(.green)
        } else if viewModel.hasPendingJoinRequest() {
            RequestStatus(imageName: "paperplane", text: "Sent")
                .foregroundStyle(.yellow)
        } else {
            Button {
                Task {
                    await viewModel.sendJoinRequest()
                }
            } label: {
                RequestStatus(imageName: "person.badge.plus", text: "Join")
            }
            .disabled(!viewModel.canJoinCommunity())
        }
    }
    
    var Issues: some View {
        
        HStack {
            VStack(alignment: .leading) {
                Text("Issues")
                    .bold()
                    .font(.title2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.top, 10)
            
            Spacer()
            
            if viewModel.isAdmin() {
                Button {
                    isShowingCreateIssueView.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                }
                .padding()
                .padding(.trailing, 24)
            }
        }
    }
}

