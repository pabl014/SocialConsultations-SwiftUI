//
//  CommunityCardView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/11/2024.
//

import SwiftUI

struct CommunityCardView: View {
    
    let community: Community
        
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
                        if let admin = community.administrators.first {
                            Text("Admin: \(admin.name) \(admin.surname) ")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        } else {
                            Text("Admin: Unknown")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "message")
                            .foregroundColor(.gray)
                        Text("392") // Możesz zastąpić to dynamiczną liczbą wiadomości, jeśli jest dostępna w modelu
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
            .frame(width: 300)
        }
}

#Preview {
    
    CommunityCardView(community: MockData.mockCommunity2)
    
    ScrollView(.horizontal) {
        HStack {
            ForEach(0..<5) { _ in
                CommunityCardView(community: MockData.mockCommunity)
            }
        }
        .frame(height: 320)
    }
    .background(Color(.systemGroupedBackground))
    .scrollIndicators(.hidden)
    .edgesIgnoringSafeArea(.horizontal)

}

