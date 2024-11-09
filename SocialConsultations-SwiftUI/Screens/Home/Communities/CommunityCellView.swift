//
//  CommunityCellView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/11/2024.
//

import SwiftUI

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
                    
                    ImageBase64View(base64String: community.avatar?.data)
                        .frame(width: 120, height: 120)
                        .clipped()
                        .cornerRadius(10)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text(community.name)
                            //.font(.headline)
                            .font(.system(size: 20, weight: .semibold))
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
            .padding(.horizontal, 8)
        }
    }
}

#Preview {
    CommunityCellView(community: MockData.mockCommunity)
    CommunityCellView(community: MockData.mockCommunity2)
    CommunityCellView(community: MockData.mockCommunity)
}
