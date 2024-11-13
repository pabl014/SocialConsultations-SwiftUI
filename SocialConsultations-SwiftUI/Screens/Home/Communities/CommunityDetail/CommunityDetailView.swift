//
//  CommunityDetailView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/11/2024.
//

import SwiftUI

struct CommunityDetailView: View {
    
    @State var selectedCat: CategoryContext = .current
    
    let community: Community
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
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
        }
        .navigationTitle(community.name)
    }
}

#Preview {
    NavigationStack {
        CommunityDetailView(community: MockData.mockCommunity)
    }
}
