//
//  ProfileView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    @Binding var showSignInView: Bool
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
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchCurrentUser()
                    isLoading = false
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingsView(showSignInView: $showSignInView)
                    } label: {
                        HStack {
                            Image(systemName: "gear")
                                .font(.headline)
                            Text("Settings")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CurrentUserProfileView(showSignInView: .constant(false))
    }
}
