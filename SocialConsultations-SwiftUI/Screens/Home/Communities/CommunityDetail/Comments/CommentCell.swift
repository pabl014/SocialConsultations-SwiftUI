//
//  CommentCell.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 26/11/2024.
//

import SwiftUI

struct CommentCell: View {
    
    let comment: Comment
    let currentUserId: Int
    let onLike: (Comment) -> Void
    //let onImageClick: (Int) -> Void
    
    @State private var isLiked: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                if let authorId = comment.author?.id {
                    
                    NavigationLink(
                        destination: UserProfileView(userId: authorId),
                        label: {
                            ImageBase64View(base64String: comment.author?.avatar?.data)
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                        }
                    )
                    .buttonStyle(PlainButtonStyle())
                    
                } else {
                    ImageBase64View(base64String: "siema")
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                }
                VStack(alignment: .leading) {
                    Text("\(comment.author?.name ?? "no name") \(comment.author?.surname ?? "no surname")")
                        .font(.headline)
                    Text(comment.createdAt.toPrettyDateString(showAge: false))
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                .padding(.leading, 4)
                
                Spacer()
                
                Button(action: {
                    if !isLiked {
                        isLiked = true // Zablokuj ponowne polubienie
                        onLike(comment) // Wywołanie logiki nadrzędnej
                    }
                }) {
                    HStack {
                        Image(systemName: "arrow.up")
                        Text("\(comment.upvotes.count)")
                    }
                    .font(.subheadline)
                    .foregroundColor(isLiked ? .white : .black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(isLiked ? Color.blue : Color.gray.opacity(0.2))
                    .itemCornerRadius(10)
                }
                .disabled(isLiked)
            }
            
            Text("State: \(comment.issueStatus)")
                .font(.subheadline)
                .foregroundStyle(.blue)
            
            Text(comment.content)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(Color.white)
        .itemCornerRadius(20)
        .shadow(color: Color.black.opacity(0.4), radius: 5)
        .padding(.horizontal, 16)
        .onAppear {
            isLiked = comment.upvotes.contains { $0.id == currentUserId }
        }
    }
}

#Preview {
    ScrollView(.vertical) {
        ForEach(0...5, id: \.self) { _ in
            CommentCell(
                comment: MockData.mockComment1, currentUserId: 4,
                onLike: { comment in
                    print("Liked comment with ID: \(comment.id)")
                } 
            )
        }
    }
}

