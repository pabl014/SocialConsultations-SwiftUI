//
//  TestHomeView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 07/11/2024.
//

import SwiftUI

struct TestHomeView: View {
    @StateObject private var viewModel = CommunityListViewModel()
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Sekcja wyszukiwania (opcjonalnie)
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
                            .padding(.horizontal, 100)
                            .background(Color.gray.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.horizontal)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 16)
                    
                    // Sekcja "Near you" z poziomym ScrollView
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Near you")
                            .font(.headline)
                            .padding(.leading, 16)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(viewModel.communities, id: \.id) { community in
                                    NavigationLink {
                                        // Tutaj widok szczegółowy, np. ConsultationsView
                                        ConsultationsView()
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
                    
                    // Sekcja "Last added" z pionowym ScrollView
                    VStack(alignment: .leading) {
                        Text("Last added")
                            .font(.headline)
                            .padding(.leading, 16)
                            .padding(.bottom, 8)
                        
                        VStack(spacing: 16) {
                            ForEach(viewModel.communities, id: \.id) { community in
                                NavigationLink {
                                    // Tutaj widok szczegółowy, np. ConsultationsView
                                    ConsultationsView()
                                } label: {
                                    CommunityCellView(community: community)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 16)
                }
            }
            .navigationTitle("Communities")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .onAppear {
            Task {
                await viewModel.loadCommunities()
            }
        }
    }
}


#Preview {
    NavigationStack {
        TestHomeView()
    }
}

@MainActor
final class CommunityListViewModel: ObservableObject {
    @Published var communities: [Community] = []
    
    func loadCommunities() async {
        do {
            self.communities = try await CommunityManager.shared.fetchCommunities()
        } catch {
            print("Failed to fetch communities:", error)
        }
    }
}
