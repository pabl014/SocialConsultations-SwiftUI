//
//  AdminRowCell.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 15/11/2024.
//

import SwiftUI

struct AdminRowCell: View {
    
    let admin: User
    
    var body: some View {
        VStack {
            ImageBase64View(base64String: admin.avatar?.data)
                .clipShape(Circle())
                .frame(width: 70, height: 70)
            
            VStack {
                Group {
                    Text("\(admin.name)")
                    Text("\(admin.surname)")
                }
                .font(.subheadline)
                .foregroundColor(.primary)
            }
        }
    }
}


#Preview {
    ScrollView(.horizontal){
        HStack(spacing: 20) {
            ForEach(1...5, id: \.self) { _ in
                AdminRowCell(admin: MockData.mockCommunity.administrators.first!)
            }
        }
        .padding(.horizontal, 24)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .scrollIndicators(.hidden)
}

