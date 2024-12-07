//
//  ProfileHeaderView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 24/11/2024.
//

import SwiftUI

struct ProfileHeaderView : View {
    
    let user: User?
    
    var body: some View {
        VStack {
            ImageBase64View(base64String: user?.avatar?.data)
                .clipShape(Circle())
                .frame(width: 150, height: 150)
                .padding()
            
            HStack {
                Text(user?.name ?? "no name")
                Text(user?.surname ?? "no surname")
            }
            .font(.title)
            
            Text(user?.email ?? "no email")
                .font(.subheadline)
            Text(user?.birthDate.toPrettyDateString(showAge: true) ?? "no birth date")
                .font(.subheadline)
            
            if let description = user?.description {
                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
            }
        }
        
    }
}


#Preview {
    ProfileHeaderView(user: MockData.mockUser2)
}
