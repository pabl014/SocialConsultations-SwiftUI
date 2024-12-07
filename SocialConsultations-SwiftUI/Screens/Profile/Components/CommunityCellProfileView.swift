//
//  CommunityCellProfileView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 24/11/2024.
//

import SwiftUI

struct CommunityCellProfileView: View {
    
    let community: CommunityProfile
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(radius: 5)
                    .frame(height: 150)
                
                HStack {
                    
                    ImageBase64View(base64String: community.avatar?.data)
                        .frame(width: 120, height: 120)
                        .clipped()
                        .itemCornerRadius(10)
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(community.name)
                            //.font(.headline)
                            .font(.system(size: 20, weight: .semibold))
                            .lineLimit(2)
                        
                        VStack {
                            HStack {
                                Image(systemName: "person.3.fill")
                                    .foregroundColor(.gray)
                                Text(String(community.members.count))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 8)
        }
    }
}

#Preview {
    CommunityCellProfileView(community: MockData.mockCommunityProfile1)
    CommunityCellProfileView(community: MockData.mockCommunityProfile1)
    CommunityCellProfileView(community: MockData.mockCommunityProfile1)
}
