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
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 16) {
                    searchButton

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
    }
    
    var searchButton: some View {
        HStack(spacing: 8) {
            Spacer()
            
            Button {
                // Akcja wyszukiwania
            } label: {
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search more...")
                }
                .font(.callout)
                .frame(minWidth: 35)
                .padding(.vertical, 8)
                .padding(.horizontal, 110)
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            Spacer()
        }
        .padding(.top, 16)
    }
    
    var nearYouScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.communities, id: \.id) { community in
                    NavigationLink {
                        CommunityDetailView(community: community)
                    } label: {
                        CommunityCardView(community: community)
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
        VStack(spacing: 16) {
            ForEach(viewModel.communities, id: \.id) { community in
                NavigationLink {
                    CommunityDetailView(community: community)
                } label: {
                    CommunityCellView(community: community)
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
