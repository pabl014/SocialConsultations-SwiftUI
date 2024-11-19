//
//  SearchCommunitiesViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 13/11/2024.
//

import Foundation

@MainActor
final class SearchCommunitiesViewModel: ObservableObject {
    
    @Published var results: [CommunityDTO] = []
    @Published var isLoadingPage = false
    
    private var currentPage = 1
    private var canLoadMorePages = true
    
    func search(name: String) async {
        self.results = []
        self.currentPage = 1
        self.canLoadMorePages = true
        await loadMoreResults(name: name)
    }
    
    func loadMoreResults(name: String) async {
        guard !isLoadingPage && canLoadMorePages else { return }
        
        isLoadingPage = true
        do {
            let newResults = try await CommunityManager.shared.searchCommunities(withName: name, pageNumber: currentPage, pageSize: 10)
            
            results.append(contentsOf: newResults)
            canLoadMorePages = !newResults.isEmpty
            if canLoadMorePages {
                currentPage += 1
            }
        } catch {
            print("Error loading more results:", error)
            canLoadMorePages = false
        }
        isLoadingPage = false
    }
}
