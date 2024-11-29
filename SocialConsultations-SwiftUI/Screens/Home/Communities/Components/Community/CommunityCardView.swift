//
//  CommunityCardView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/11/2024.
//

import SwiftUI

struct CommunityCardView: View {
    
    let community: CommunityHome
        
        var body: some View {
            VStack {
                
                ImageBase64View(base64String: community.avatar?.data)
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(20)
                
                
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
                        if community.isPublic {
                            Text("Public")
                                .font(.subheadline)
                                .foregroundColor(.green)
                        } else {
                            Text("Private")
                                .font(.subheadline)
                                .foregroundColor(.red)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "person.3.fill")
                            .foregroundColor(.gray)
                        Text(String(community.members.count))
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
            .frame(width: 300, height: 300)
        }
}

#Preview {
    ScrollView(.vertical) {
        CommunityCardView(community: MockData.mockCommunityHome3)
        
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<5) { _ in
                    CommunityCardView(community: MockData.mockCommunityHome2)
                }
            }
            .frame(height: 320)
        }
        .background(Color(.systemGroupedBackground))
        .scrollIndicators(.hidden)
        .edgesIgnoringSafeArea(.horizontal)
        
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<5) { _ in
                    CommunityCardView(community: MockData.mockCommunityHome1)
                }
            }
            .frame(height: 320)
        }
        .background(Color(.systemGroupedBackground))
        .scrollIndicators(.hidden)
        .edgesIgnoringSafeArea(.horizontal)
    }

}

