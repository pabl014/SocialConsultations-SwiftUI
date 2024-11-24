//
//  CommunityListView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 24/11/2024.
//

import SwiftUI

struct CommunityListView: View {
    
    let communities: [CommunityProfile]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            if communities.isEmpty {
                ContentUnavailableView(
                    "No Communities",
                    systemImage: "xmark"
                )
            } else {
                ForEach(communities, id: \.id) { community in
                    NavigationLink {
                        CommunityDetailView(communityID: community.id)
                    } label: {
                        CommunityCellProfileView(community: community)
                            .contextMenu {
                                Text(community.description)
                            }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}


#Preview {
    CommunityListView(communities: [MockData.mockCommunityProfile1, MockData.mockCommunityProfile1])
}
