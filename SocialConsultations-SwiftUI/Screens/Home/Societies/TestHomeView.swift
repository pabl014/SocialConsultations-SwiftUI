//
//  TestHomeView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 07/11/2024.
//

import SwiftUI

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
                                        CommunityHeaderCardView(community: community)
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
            .onAppear {
                Task {
                    await viewModel.loadCommunities()
                }
            }
            
        }
    }
}


#Preview {
    TestHomeView()
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


struct CommunityCellView: View {
    let community: Community
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(radius: 5)
                    .frame(height: 150)
                
                HStack {
                    if let avatarData = community.avatar?.data {
                        ImageBase64View(base64String: avatarData)
                            .frame(width: 120, height: 120)
                            .clipped()
                            .cornerRadius(10)
                            .padding()
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 120, height: 120)
                            .overlay(
                                Text("No Image")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            )
                            .padding()
                    }
                    
                    VStack(alignment: .leading) {
                        Text(community.name)
                            .font(.headline)
                            .lineLimit(2)
                        
                        if let firstAdmin = community.administrators.first {
                            Text("Admin: \(firstAdmin.name) \(firstAdmin.surname)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.top, 2)
                        } else {
                            Text("Community")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.top, 2)
                        }
                    }
                    .padding(.leading, 5)
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CommunityHeaderCardView: View {
    let community: Community
        
        var body: some View {
            VStack {
                if let avatarData = community.avatar?.data {
                    ImageBase64View(base64String: avatarData)
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(20)
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 200)
                        .overlay(
                            Text("No Image")
                                .foregroundColor(.gray)
                                .font(.caption)
                        )
                }
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text(community.name)
                            .font(.headline)
                            .lineLimit(2)
                            .padding(.bottom, 5)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    HStack {
                        if let adminName = community.administrators.first?.name {
                            Text("Admin: \(adminName)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        } else {
                            Text("Admin: Unknown")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "message")
                            .foregroundColor(.gray)
                        Text("392") // Możesz zastąpić to dynamiczną liczbą wiadomości, jeśli jest dostępna w modelu
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .padding(.top, -8)
            }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding(.horizontal)
            .frame(width: 300)
        }
}
