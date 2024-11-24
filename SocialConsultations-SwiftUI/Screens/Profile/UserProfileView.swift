//
//  UserProfileView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 19/11/2024.
//

import SwiftUI

struct UserProfileView: View {
    
    let userId: Int
    @StateObject private var viewModel = ProfileViewModel()
    @State private var isLoading = true
    @State private var selectedCat: CommunityCategoryContext = .member
    
    var body: some View {
        ZStack {
            Color(hex: "#F2F2F2")
                .ignoresSafeArea()
            
            VStack {
                if isLoading {
                    LoadingView()
                        .frame(width: 100, height: 100)
                        .padding()
                } else {
                    ScrollView {
                        ProfileHeaderView(user: viewModel.user)
                        
                        VStack(spacing: 16) {
                            
                            Picker("Selected Category", selection: $selectedCat) {
                                ForEach(CommunityCategoryContext.allCases) { content in
                                    Text(content.title)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.horizontal, 2)
                            .padding(.bottom, 16)
                            
                            if selectedCat == .member {
                                CommunityListView(communities: viewModel.communitiesMember)
                            } else if selectedCat == .admin {
                                CommunityListView(communities: viewModel.communitiesAdmin)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 32)
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchUser(with: userId)
                    isLoading = false
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct UserProfileView_Preview: View {
    
    @State private var selectedCat: CommunityCategoryContext = .member
    
    var body: some View {
        VStack {
            ScrollView {
                
                ProfileHeaderView(user: MockData.mockUser1)
                
                VStack(spacing: 16) {
                    
                    Picker("Selected Category", selection: $selectedCat) {
                        ForEach(CommunityCategoryContext.allCases) { content in
                            Text(content.title)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 2)
                    .padding(.bottom, 16)
                    
                    if selectedCat == .member {
                        CommunityListView(communities: [MockData.mockCommunityProfile1, MockData.mockCommunityProfile1])
                    } else if selectedCat == .admin {
                        CommunityListView(communities: [MockData.mockCommunityProfile1])
                    }
                }
                .padding(.horizontal)
                .padding(.top, 32)
            }
        }
        .navigationTitle("User Profile")
    }
}

#Preview {
    NavigationStack {
        UserProfileView_Preview()
    }
}
