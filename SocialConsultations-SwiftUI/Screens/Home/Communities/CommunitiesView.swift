//
//  CommunitiesView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/11/2024.
//

import SwiftUI

struct CommunitiesView: View {
    
    @StateObject private var viewModel = CommunitiesViewModel()
    
    var body: some View {
        ZStack {
            Color(hex: "#F2F2F2")
                .ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 16) {
                    blankSpace

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Near you")
                            .font(.headline)
                            .padding(.leading, 16)
                            .padding(.bottom, 8)
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .padding()
                        } else if viewModel.communities.isEmpty {
                            Text("No communities near your location")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            nearYouScrollView
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Might interest you")
                            .font(.headline)
                            .padding(.leading, 16)
                            .padding(.bottom, 8)
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .padding()
                        } else {
                            communitiesList
                        }
                    }
                    .padding(.top, 16)
                }
            }
            .refreshable {
                Task {
                    await viewModel.loadCommunities()
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadCommunities()
                }
            }
        }
        .navigationTitle("Communities")
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SearchCommunitiesView()
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .font(.title3)
                }
            }
        }
    }
    
    var blankSpace: some View {
        HStack(spacing: 8) {
            Spacer()
        }
    }
    
    var nearYouScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.communities, id: \.id) { community in
                    NavigationLink {
                        CommunityDetailView(community: community)
                    } label: {
                        CommunityCardView(community: community)
                            .contextMenu {
                                Text(community.description)
                            }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(height: 320)
                }
            }
            .padding(.horizontal)
        }
        .background(Color(.systemGroupedBackground))
    }
    
    var communitiesList: some View {
        LazyVStack(spacing: 16) {
            ForEach(viewModel.communities, id: \.id) { community in
                NavigationLink {
                    CommunityDetailView(community: community)
                } label: {
                    CommunityCellView(community: community)
                        .contextMenu {
                            Text(community.description)
                        }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        CommunitiesView()
    }
}
