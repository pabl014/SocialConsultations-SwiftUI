//
//  TabbarView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct TabbarView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            NavigationStack {
                ForumView()
            }
            .tabItem {
                Image(systemName: "bubble.left.and.bubble.right")
                Text("Consultations")
            }
            
            NavigationStack {
                PollsView()
            }
            .tabItem {
                Image(systemName: "chart.pie.fill")
                Text("Polls")
            }
            
            NavigationStack {
                ProfileView(showSignInView: $showSignInView)
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
            
        }
    }
}

#Preview {
    TabbarView(showSignInView: .constant(false))
}
