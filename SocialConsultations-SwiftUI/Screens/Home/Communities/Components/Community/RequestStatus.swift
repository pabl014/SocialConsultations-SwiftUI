//
//  RequestStatus.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 25/11/2024.
//

import SwiftUI

struct RequestStatus: View {
    
    let imageName: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            Text(text)
        }
    }
}

#Preview {
    Group {
        RequestStatus(imageName: "bolt.shield", text: "Admin")
            .foregroundStyle(.green)
        
        RequestStatus(imageName: "person", text: "Member")
            .foregroundStyle(.green)
        
        RequestStatus(imageName: "paperplane", text: "Sent")
            .foregroundStyle(.yellow)
        
        RequestStatus(imageName: "person.badge.plus", text: "Join")
            .foregroundStyle(.blue)
    }
    .font(.title)
    .padding()
}
