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
                    VStack(alignment: .leading) {
                        ImageBase64View(base64String: loadedCommunity.background?.data)
                            .frame(height: 250)
                            .clipped()
                            .itemCornerRadius(20)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(loadedCommunity.description)
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                        .padding()
                    }
                    .background(Color(UIColor.secondarySystemBackground))
                    .itemCornerRadius(20)
                    .shadow(radius: 5)
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Issues")
                            .bold()
                            .font(.title2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 10)
                    
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
                    .padding(.top, 16)
                    
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
        .onAppear {
            Task {
                if viewModel.community == nil, let communityID = communityID {
                    await viewModel.fetchCommunityDetails(id: communityID)
                } else {
                    viewModel.community = community
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CommunityDetailView(community: MockData.mockCommunity, communityID: nil)
    }
}
