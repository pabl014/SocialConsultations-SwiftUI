//
//  CommunityDetailView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/11/2024.
//

import SwiftUI

struct CommunityDetailView: View {
    
    @State var selectedCat: CategoryContext = .current
    
    let community: Community?
    let communityID: Int?
    
    @StateObject private var viewModel = CommunityDetailViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let loadedCommunity = viewModel.community ?? community {
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
                    
                    Issues
                    
                    VStack(spacing: 16) {
                        Picker("Selected Category", selection: $selectedCat) {
                            ForEach(CategoryContext.allCases) { content in
                                Text(content.title)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal, 2)
                        .padding(.bottom, 16)
                    }
                    .padding(.horizontal)
                    .padding(.top, 4)
                    
                    ForEach(0..<5) { _ in
                        NavigationLink {
                            ConsultationDetailView()
                        } label: {
                            HomeCellView()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            } else {
                Text("Community details could not be loaded.")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle(viewModel.community?.name ?? community?.name ?? "Community")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if viewModel.isAdmin() {
                    RequestStatus(imageName: "bolt.shield", text: "Admin")
                        .foregroundStyle(.green)
                } else if viewModel.isMember() {
                    RequestStatus(imageName: "person", text: "member")
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
                        RequestStatus(imageName: "person.badge.plus", text: "Join Community")
                    }
                    .disabled(!viewModel.canJoinCommunity())
                }
            }
        }
        .onAppear {
            if viewModel.community == nil, let communityID = communityID {
                Task {
                    await viewModel.fetchCommunityDetails(id: communityID)
                }
            } else if viewModel.community == nil {
                viewModel.community = community
            }
            
            Task {
                await viewModel.fetchCurrentUser()
            }
        }
    }
    
    
//    var Administrators: some View {
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
    
    private func handleJoinRequest() async {
        if viewModel.canJoinCommunity() {
            await viewModel.sendJoinRequest()
        }
    }
}

#Preview {
    NavigationStack {
        CommunityDetailView(community: MockData.mockCommunity, communityID: nil)
    }
}

struct CommunityHeader: View {
    
    let community: Community

    var body: some View {
        VStack(alignment: .leading) {
            ImageBase64View(base64String: community.background?.data)
                .frame(height: 250)
                .clipped()
                .itemCornerRadius(20)

            VStack(alignment: .leading, spacing: 10) {
                Text(community.description)
                    .font(.body)
                    .foregroundColor(.primary)
            }
            .padding()
        }
        .background(Color(UIColor.secondarySystemBackground))
        .itemCornerRadius(20)
        .shadow(radius: 5)
        .padding()
    }
}

struct RequestStatus: View {
    
    let imageName: String
    let text: String
    
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            Text(text)
        }
    }
}
