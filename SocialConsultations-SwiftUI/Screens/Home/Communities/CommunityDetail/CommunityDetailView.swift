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
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let loadedCommunity = viewModel.community {
                ScrollView(.vertical) {
                    CommunityHeader(community: loadedCommunity)
                    
                    //                    VStack(alignment: .leading, spacing: 10) {
                    //
                    //                        Administrators
                    //
                    //                        ScrollView(.horizontal){
                    //                            HStack(spacing: 20) {
                    //                                ForEach(loadedCommunity.administrators, id: \.id) { admin in
                    //                                    AdminRowCell(admin: admin)
                    //                                }
                    //                            }
                    //                            .padding(.horizontal, 24)
                    //                        }
                    //                        .frame(maxWidth: .infinity, alignment: .leading)
                    //                        .scrollIndicators(.hidden)
                    //                    }
                    
                    ExpandableMapView(lat: Double(loadedCommunity.latitude), long: Double(loadedCommunity.longitude))
                    
                    if viewModel.isAdmin() {
                        NavigationLink {
                            JoinRequestsView(joinRequests: loadedCommunity.joinRequests, communityId: loadedCommunity.id)
                        } label: {
                            Text("See join requests")
                                .secondaryButtonStyle()
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
    
    //   var Administrators: some View {
    //        Text("Administrators")
    //            .font(.title2)
    //            .bold()
    //            .padding(.top, 10)
    //            .padding(.horizontal, 24)
    //    }
        
    var Issues: some View {
        VStack(alignment: .leading) {
            Text("Issues")
                .bold()
                .font(.title2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .padding(.top, 10)
    }
}

#Preview {
    NavigationStack {
        CommunityDetailView(communityID: MockData.mockCommunityDetail.id)
    }
}

