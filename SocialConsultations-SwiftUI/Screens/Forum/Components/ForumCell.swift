//
//  ForumCell.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 15/10/2024.
//

import SwiftUI

struct ForumCell: View {
    
    var body: some View {
        version1
    }
    
    var version1: some View {
        HStack(alignment: .center, spacing: 16) {
            ImageBase64View(base64String: Constants.example64)
                .frame(width: 64, height: 64)
                .itemCornerRadius(12)
            
            VStack(alignment: .leading) {
                Text("Electric cars in city")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("Society of Bialystok residents")
                    .font(.subheadline)
                
                Text("Admin: Jan Kowalski")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    var version2: some View {
        HStack(alignment: .center, spacing: 16) {
            ImageBase64View(base64String: Constants.example64)
                .frame(width: 64, height: 64)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Electric cars in city")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("Society of Bialystok residents")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Admin: Jan Kowalski")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)
        )
        .padding(.horizontal)
    }
}

#Preview {
    List {
        ForEach(0..<10) { cell in
            ForumCell()
        }
    }
}
