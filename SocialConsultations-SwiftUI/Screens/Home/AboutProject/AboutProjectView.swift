//
//  AboutProjectView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 19/11/2024.
//

import SwiftUI

struct AboutProjectView: View {
    var body: some View {
        ZStack {
            Color(hex: "#F2F2F2")
                .ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack {
                    Image("peopleTalking")
                        .resizable()
                        .scaledToFit()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("This platform is here to help make your voice heard in important community decisions. It’s a space where you can share your opinions, give feedback, and participate in public consultations on various topics. Whether it’s about local development, new policies, or community projects, your input matters. The platform is easy to use, allowing you to join discussions, answer surveys, and stay updated on the decisions that affect you. Together, we can shape the future of our community!")
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    .sectionShadowStyle()
                }
            }
            
        }
        .navigationTitle("About Project")
    }
}

#Preview {
    NavigationStack {
        AboutProjectView()
    }
}
