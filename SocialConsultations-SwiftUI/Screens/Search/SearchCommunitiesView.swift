//
//  SearchCommunitiesView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 13/11/2024.
//

import SwiftUI

struct SearchCommunitiesView: View {
    
    @StateObject private var viewModel = SearchCommunitiesViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack {
            Color(hex: "#F2F2F2")
                .ignoresSafeArea()
            
            VStack {
                if viewModel.results.isEmpty {
                    if searchText.count < 3 {
                        searchForCommunities
                    } else {
                        noResults
                    }
                } else {
                    
                    List(viewModel.results, id: \.id) { community in
                        NavigationLink {
                            CommunityDetailView(communityID: community.id)
                        } label: {
                            Text(community.name)
                        }
                        .onAppear {
                            if community == viewModel.results.last { // ostatni element
                                Task {
                                    await viewModel.loadMoreResults(name: searchText)
                                }
                            }
                        }
                    }
                    
                    if viewModel.isLoadingPage {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                    
                }
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) {
                Task {
                    if !searchText.isEmpty && searchText.count >= 3 {
                        await viewModel.search(name: searchText)
                    } else {
                        viewModel.results.removeAll()
                    }
                }
            }
            .navigationTitle("Search")
        }
    }
    
    
    var searchForCommunities: some View {
        ContentUnavailableView(
            "Search for communities",
            systemImage: "rectangle.and.text.magnifyingglass",
            description: Text("You need to write at least 3 letters to start searching ")
        )
    }
    var noResults: some View {
        ContentUnavailableView(
            "No results for \"\(searchText)\"",
            systemImage: "xmark.circle",
            description: Text("Try adjusting your search or filters.")
        )
    }
}

#Preview {
    NavigationStack {
        SearchCommunitiesView()
    }
}
