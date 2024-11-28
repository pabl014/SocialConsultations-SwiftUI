//
//  PostCell.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 15/10/2024.
//

import SwiftUI

struct PostCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading) {
                    Text("Jose Mourinho")
                        .font(.headline)
                    Text("6 hours ago")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae erat eu nisi molestie! Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae erat eu nisi molestie!")
            
            HStack {
                
                Button(action: {
                    // Akcja dla dodania
                }) {
                    HStack {
                        Image(systemName: "arrow.up")
                            
                        Text("78 Like")
                    }
                    .font(.subheadline)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.gray.opacity(0.2))
                    .itemCornerRadius(10)
                }
                
                Button(action: {
                    // Akcja dla dodania
                }) {
                    HStack {
                        Image(systemName: "arrow.down")
                        Text("3 Dislike")
                    }
                    .font(.subheadline)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.gray.opacity(0.2))
                    .itemCornerRadius(10)
                }
            }
            .foregroundColor(.gray)
        }
        .padding()
        //.background(Color(UIColor.secondarySystemBackground))
        .background(Color.white)
        .itemCornerRadius(20)
        //.shadow(color: Color.black.opacity(0.4), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.4), radius: 5)
        .padding()
    }
}

#Preview {
    PostCell()
    PostCell()
    PostCell()
}
