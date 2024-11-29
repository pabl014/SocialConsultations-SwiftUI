//
//  CommunityHeader.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 25/11/2024.
//

import SwiftUI

struct CommunityHeader: View {
    
    let community: CommunityDetail

    var body: some View {
        VStack(alignment: .leading) {
            ImageBase64View(base64String: community.background?.data)
                .frame(height: 250)
                .clipped()
                .itemCornerRadius(20)

            VStack(alignment: .leading, spacing: 10) {
                
                HStack {
                    if let admin = community.administrators.first {
                        
                        NavigationLink(destination: UserProfileView(userId: admin.id)) {
                            
                            VStack(alignment: .leading, spacing: 2) {
                                
                                Text("\(admin.name) \(admin.surname)")
                                    .font(.callout)
                                    .foregroundColor(.secondary)
                                
                                Text("Administrator")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                
                Divider()
                
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


#Preview {
    CommunityHeader(community: MockData.mockCommunityDetail)
}
